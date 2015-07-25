//
//  ImageCollectionViewController.swift
//  Phoneme
//
//  Created by donal on 23/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer = AVAudioPlayer()

class ImageCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let task: Task = Task(intro:"Intro", title:"Familiarisation", items:[TaskItem(audio:"Fam1", images:["green-box"], correctImage:"green-box"),
        TaskItem(audio:"Fam3", images:["mouse", "seal", "dog"], correctImage:"dog"),
        TaskItem(audio:"Fam4", images:["cat", "bear", "spider"], correctImage:"cat"),
        TaskItem(audio:"Fam5", images:["fly", "bee", "snake"], correctImage:"bee"),
        TaskItem(audio:"Fam6", images:["cow", "pig", "fish"], correctImage:"fish")])
    
    var counter = 0

    
    
    override func viewDidAppear(animated: Bool) {
        playAudioTrack()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return task.items[counter].images.count;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomImageCell
        
        cell.selected = false
        
        let img = UIImage(named: task.items[counter].images[indexPath.row])
        cell.imageCell.image = img
        cell.name = task.items[counter].images[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width :CGFloat = (collectionView.frame.size.width / CGFloat(task.items[counter].images.count)) - 20;
        
        return CGSize(width: width, height: collectionView.frame.width - 300)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        counter++
        
        if(counter >= task.items.count){
            counter = 0
        }
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
    
        collectionView.reloadData()
        
        playAudioTrack()
    }
    
    func playAudioTrack(){
        
        let sound = task.items[counter].audio
        
        
        let soundURL = NSBundle.mainBundle().URLForResource(sound, withExtension: "mp4")
        
        audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        audioPlayer.play()
    }
}
