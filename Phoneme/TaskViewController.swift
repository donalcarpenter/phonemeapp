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
    
    var delegate: ImageCollectionViewControllerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var bgimgOw: UIImageView?
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        task = delegate!.task
        let count: Int = task!.items.count
        answers = [String](count:count, repeatedValue: "")
        
        let bgimgO = UIImage(named: "background")
        bgimgOw = UIImageView(frame: self.view.frame)
        bgimgOw!.image = bgimgO
        
        self.view.insertSubview(bgimgOw!, atIndex: 1)
        
        self.navigationController?.navigationBarHidden = true
        
        self.collectionView.hidden = true
    }
    
    func loadTaskItems(){
        
    }
    
    func processResults(){
        delegate?.uploadResults(taskResults)
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
            let taskCell = cell as! CustomImageCell
            if (taskCell.name != correctImage){
            UIView.animateWithDuration(0.2){
                            taskCell.imageCell.alpha = 0
                }
            }
        }
    }
    
    func moveToNextTaskItem(){
        counter++
        
        if(counter >= task!.items.count){
            
            processResults()
            
            audioPlayer.stop()
            
            self.navigationController?.popViewControllerAnimated(true)
            
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
        return task!.items[counter].images.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomImageCell
        
        cell.selected = false
        cell.imageCell.alpha = 1
        
        let img = UIImage(named: task!.items[counter].images[indexPath.row])
        cell.imageCell.image = img
        cell.name = task!.items[counter].images[indexPath.row]
        
        cell.userInteractionEnabled = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width :CGFloat = (collectionView.frame.size.width / CGFloat(task!.items[counter].images.count)) - 20;
        
        return CGSize(width: width, height: collectionView.frame.height - 40)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if(!task!.items[counter].requireResponse){
            return
        }
        
        // capture current answer
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CustomImageCell
        answers?[counter] = cell.name!
        
        var result = TaskResultRawItem(index: counter, correctAnswer: task!.items[counter].correctImage, givenAnswer: cell.name!)
        
        taskResults.append(result)
        
        NSLog("expected \(task!.items[counter].correctImage), got \(cell.name!)")
        
        
        moveToNextTaskItem()
    }
    
    func playTaskItemAudioTrack(){
        
        let sound = task!.items[counter].audio
        
        audioManager.playAudioFrom(sound)
    }

}
