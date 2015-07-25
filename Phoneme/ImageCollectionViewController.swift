//
//  ImageCollectionViewController.swift
//  Phoneme
//
//  Created by donal on 23/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer1 = AVAudioPlayer()

protocol ImageCollectionViewControllerDelegate{
    var task : Task { get }
}

class ImageCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    var task: Task?
    var counter = 0

    
    var delegate: ImageCollectionViewControllerDelegate?
    
    override func viewWillAppear(animated: Bool) {
        task = delegate!.task
    }
    
    override func viewDidAppear(animated: Bool) {
        playAudioTrack()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return task!.items[counter].images.count;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomImageCell
        
        cell.selected = false
        
        let img = UIImage(named: task!.items[counter].images[indexPath.row])
        cell.imageCell.image = img
        cell.name = task!.items[counter].images[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width :CGFloat = (collectionView.frame.size.width / CGFloat(task!.items[counter].images.count)) - 20;
        
        return CGSize(width: width, height: collectionView.frame.width - 300)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        counter++
        
        if(counter >= task!.items.count){
            counter = 0
        }
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
    
        collectionView.reloadData()
        
        playAudioTrack()
    }
    
    func playAudioTrack(){
        
        let sound = task!.items[counter].audio
        
        let soundURL = NSBundle.mainBundle().URLForResource(sound, withExtension: "mp4")
        
        audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        audioPlayer.play()
    }
}
