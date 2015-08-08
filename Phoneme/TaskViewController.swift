//
//  TaskViewController.swift
//  Phoneme
//
//  Created by donal on 25/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class TaskViewController: BaseUIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    var task: Task?
    var counter = 0
    var answers : [String]?
    let audioManager = AudioManager()
    var taskResults = [TaskResultRawItem]()
    let bgimgO = UIImage(named: "background")
    
    var delegate: ImageCollectionViewControllerDelegate?
    
    var rows = 1
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var bgimgOw: UIImageView?
    
    override func viewWillAppear(animated: Bool) {
        
        showBackgroundBlur = false
        
        super.viewWillAppear(animated)
        
        task = delegate!.task
        let count: Int = task!.items.count
        answers = [String](count:count, repeatedValue: "")
        
        bgimgOw = UIImageView(frame: self.view.frame)
        bgimgOw!.image = bgimgO
        
        self.view.insertSubview(bgimgOw!, atIndex: 1)
        
        self.navigationController?.navigationBarHidden = true
        
        self.collectionView.hidden = true
    }
    
    func loadTaskItems(){
        preconditionFailure("This method must be overridden")
    }
    
    func processResults(){
        delegate?.uploadResults(taskResults)
    }
    
    func setTaskItemOptionView(view:UIView, task:TaskItem, index: Int){
        preconditionFailure("This method must be overridden")
    }
    
    override func viewDidAppear(animated: Bool) {
        
        audioManager.playAudioFrom(task!.intro, completionBlock: { () -> Void in
            
            self.collectionView.hidden = false;
            
            UIView.animateWithDuration(0.5){
                self.bgimgOw!.alpha = 0
            }
            
            
            self.presentTask(0)
        })
        
    }
    
    func hideImagesThatArentCorrect(collection: UICollectionView, correctImage: String){
        for cell in collection.visibleCells(){
            let taskCell = cell as! TaskItemOptionCell
            if (taskCell.name != correctImage){
            UIView.animateWithDuration(0.2){
                    taskCell.presentationView().alpha = 0
                }
            }
        }
    }
    
    func moveToNextTaskItem(){
        counter++
        
        if(counter >= task!.items.count){
            

            audioPlayer.stop()
            
            let cont = {()-> Void in
                self.processResults()
                self.navigationController?.popViewControllerAnimated(true)
            }
            
            if self.task!.outro != nil{
                UIView.animateWithDuration(0.5){
                    self.collectionView.alpha = 0
                    self.bgimgOw!.alpha = 1
                }
                
                audioManager.playAudioFrom(task!.outro!, completionBlock: cont)
                
            }else{
                cont()
            }
        }
        else{

            loadTaskItems()
            
            presentTask(counter)
        }
    }
    
    func presentTask(counterIndex: Int){
        if(!self.task!.items[counterIndex].requireResponse){
            
            var c = counterIndex
            
            audioManager.playAudioFrom(task!.items[c].audio, completionBlock: { () -> Void in
                
                let cont = {()-> Void in
                    self.moveToNextTaskItem()}
                
                if(self.task!.items[c].outro != nil){
                    
                    self.hideImagesThatArentCorrect(self.collectionView, correctImage: self.task!.items[c].correctImage)
                    
                    self.audioManager.playAudioFrom(self.task!.items[c].outro!, completionBlock: cont)
                    
                }else{
                    cont()
                }
            })
            
        }else{
            
            if(counterIndex == 0){
                loadTaskItems()
            }
            
            playTaskItemAudioTrack()
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        NSLog("There are \(task!.items[counter].images.count) items")
        return task!.items[counter].images.count;
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.selected = false
        
        if let customCell = cell as? TaskItemOptionCell{
            let optionView = customCell.presentationView()
            
            customCell.name = task!.items[counter].images[indexPath.row]
            
            setTaskItemOptionView(optionView, task:task!.items[counter], index:indexPath.row)
        
            if(indexPath.row < task!.items[counter].optionsCascade.count && task!.items[counter].optionsCascade[indexPath.row] > 0){
                
                optionView.alpha = 0.2
                cell.userInteractionEnabled = false
                
                let delay = task!.items[counter].optionsCascade[indexPath.row]
                
                dispatch_after(
                    dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                        cell.userInteractionEnabled = true
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            optionView.alpha = 1
                        })
                })
            }else{
                optionView.alpha = 1
                cell.userInteractionEnabled = true
            }
        }
        
        
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width :CGFloat = (collectionView.frame.size.width / CGFloat(task!.items[counter].images.count / rows)) - 20;
        let height: CGFloat = (collectionView.frame.height - 20) / CGFloat(rows)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if(!task!.items[counter].requireResponse){
            return
        }
        
        // capture current answer
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TaskItemOptionCell
        answers?[counter] = cell.name!
        
        var result = TaskResultRawItem(index: counter, correctAnswer: task!.items[counter].correctImage, givenAnswer: cell.name!)
        
        taskResults.append(result)
        
        NSLog("expected \(task!.items[counter].correctImage), got \(cell.name!)")
        
        
        let cont = {()-> Void in
            self.moveToNextTaskItem()}
        
        if(self.task!.items[counter].outro != nil){
            
            self.hideImagesThatArentCorrect(self.collectionView, correctImage: self.task!.items[counter].correctImage)
            
            self.audioManager.playAudioFrom(self.task!.items[counter].outro!, completionBlock: cont)
            
        }else{
            cont()
        }
    }
    
    func playTaskItemAudioTrack(){
        
        let sound = task!.items[counter].audio
        
        audioManager.playAudioFrom(sound)
    }

}
