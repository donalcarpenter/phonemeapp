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
    
    override func viewWillAppear(animated: Bool) {
        task = delegate!.task
        let count: Int = task!.items.count
        answers = [String](count:count, repeatedValue: "")
    }
    
    func loadTask(){
        
    }
    
    func processResults(){
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        weak var weakself = self;
        
        self.navigationController?.navigationBarHidden = true
        
        audioManager.playAudioFrom(task!.intro, completionBlock: { () -> Void in
            if(!weakself!.task!.items[0].requireResponse){
                
                weakself!.audioManager.playAudioFrom(weakself!.task!.items[0].audio, completionBlock: {
                    () -> Void in
                    weakself!.moveToNextTaskItem()
                })
                
            }else{
                
                weakself!.loadTask()
                
                weakself!.playTaskItemAudioTrack()
            }
        })
        
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
                
                audioManager.playAudioFrom(task!.items[counter].audio, completionBlock: { () -> Void in
                    weakself!.moveToNextTaskItem()
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
