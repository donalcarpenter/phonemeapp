//
//  TaskViewController.swift
//  Phoneme
//
//  Created by donal on 25/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    var task: Task?
    var counter = 0
    var answers : [String]?
    let audioManager = AudioManager()
    
    var delegate: ImageCollectionViewControllerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var bgimgOw: UIImageView?
    
    override func viewWillAppear(animated: Bool) {
        task = delegate!.task
        let count: Int = task!.items.count
        answers = [String](count:count, repeatedValue: "")
        
        self.collectionView.hidden = true
        
        let bgimg = UIImage(named: "background-blur")
        let bgimgw = UIImageView(frame: self.view.frame)
        bgimgw.image = bgimg
        
        self.view.insertSubview(bgimgw, atIndex: 0)
        
        let bgimgO = UIImage(named: "background")
        bgimgOw = UIImageView(frame: self.view.frame)
        bgimgOw!.image = bgimgO
        
        self.view.insertSubview(bgimgOw!, atIndex: 1)
    }
    
    func loadTask(){
        
    }
    
    func processResults(){
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        weak var weakself = self;
        
        self.navigationController?.navigationBarHidden = true
        
        self.collectionView.hidden = true
        
        audioManager.playAudioFrom(task!.intro, completionBlock: { () -> Void in
            
            self.collectionView.hidden = false;
            
            UIView.animateWithDuration(0.5){
                weakself!.bgimgOw!.alpha = 0
            }
            
            if(!weakself!.task!.items[0].requireResponse){
                
                // play the audio
                weakself!.audioManager.playAudioFrom(weakself!.task!.items[0].audio, completionBlock: {
                    () -> Void in
                    
                    let cont = {()-> Void in
                        weakself!.moveToNextTaskItem()}
                    
                    if(weakself!.task!.items[0].outro != nil){
                        
                        weakself!.hideImagesThatArentCorrect(weakself!.collectionView, correctImage: weakself!.task!.items[0].correctImage)
                        
                        weakself!.audioManager.playAudioFrom(weakself!.task!.items[0].outro!, completionBlock: cont)
                    }else{
                        cont()
                    }
                })
                
            }else{
                
                weakself!.loadTask()
                
                weakself!.playTaskItemAudioTrack()
            }
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

            loadTask()
            
            if(!task!.items[counter].requireResponse){
                weak var weakself = self;
                
                var c = counter
                
                audioManager.playAudioFrom(task!.items[c].audio, completionBlock: { () -> Void in
                    
                    let cont = {()-> Void in
                        weakself!.moveToNextTaskItem()}
                    
                    if(weakself!.task!.items[c].outro != nil){
                        weakself!.hideImagesThatArentCorrect(weakself!.collectionView, correctImage: weakself!.task!.items[c].correctImage)
                        weakself!.audioManager.playAudioFrom(weakself!.task!.items[c].outro!, completionBlock: cont)
                    }else{
                        cont()
                    }
                })
                
            }else{
                
                playTaskItemAudioTrack()
                
            }
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
        NSLog(cell.name!)
        
        moveToNextTaskItem()
    }
    
    func playTaskItemAudioTrack(){
        
        let sound = task!.items[counter].audio
        
        audioManager.playAudioFrom(sound)
    }

}
