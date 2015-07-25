//
//  SingleRowImageTask.swift
//  Phoneme
//
//  Created by donal on 25/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer = AVAudioPlayer()

protocol ImageCollectionViewControllerDelegate{
    var task : Task { get }
}

class SingleRowImageTask: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, AVAudioPlayerDelegate {
    
    var task: Task?
    var counter = 0
    var answers : [String]?
    
    var delegate: ImageCollectionViewControllerDelegate?
    
    let postSynchronousPlaybackQueue = Queue<NSOperation>()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(animated: Bool) {
        task = delegate!.task
        let count: Int = task!.items.count
        answers = [String](count:count, repeatedValue: "")
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        // urghh, this is needed because the api of AVAudioPlayer sucks so much... There is no 
        // abilty to pass it a closure with a completion callback. so we need to do all this 
        // crazy carry on...
        while(!postSynchronousPlaybackQueue.isEmpty()){
            NSOperationQueue.mainQueue().addOperation(postSynchronousPlaybackQueue.dequeue()!)
        }
    }
    
    override func viewDidAppear(animated: Bool) {

        weak var weakself = self;
        
        self.navigationController?.navigationBarHidden = true
        
        postSynchronousPlaybackQueue.enqueue(NSBlockOperation(block: { () -> Void in
            if(!weakself!.task!.items[0].requireResponse){
                
                
                weakself!.postSynchronousPlaybackQueue.enqueue(NSBlockOperation(block: { () -> Void in
                    weakself!.moveToNextTaskItem()
                    }))
                
                weakself!.playMp4Audio(weakself!.task!.items[0].audio, async: false)
                
            }else{
                weakself!.playTaskItemAudioTrack()
            }
        }))
        
        playMp4Audio(task!.intro, async: false)
    }
    
    func moveToNextTaskItem(){
        counter++
        
        if(counter >= task!.items.count){
            
            // push results somewhere
            
            audioPlayer.stop()
            
            self.navigationController?.popViewControllerAnimated(true)
            
        }
        else{
            collectionView.reloadData()
            
            if(!task!.items[counter].requireResponse){
                weak var weakself = self;
                
                weakself!.postSynchronousPlaybackQueue.enqueue(NSBlockOperation(block: { () -> Void in
                    weakself!.moveToNextTaskItem()
                }))
                
                playMp4Audio(task!.items[counter].audio, async: false)
                
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
        

        playMp4Audio(sound)
    }
    
    func playMp4Audio(source:String, async:Bool = true){
        let soundURL = NSBundle.mainBundle().URLForResource(source, withExtension: "mp4")
        audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        audioPlayer.delegate = postSynchronousPlaybackQueue.isEmpty() ? nil : self
        audioPlayer.play()
    }
}
