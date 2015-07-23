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

        var images: [[String]] = [
            ["Fam1", "green-box"],
            ["Fam3", "mouse", "seal", "dog"], ["Fam4", "cat", "bear", "spider"],
            ["Fam5", "fly", "bee", "snake"],
            ["Fam6", "cow", "pig", "fish"]
    ]
    
    var counter = 0;
    
    override func viewDidAppear(animated: Bool) {
        playAudioTrack()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images[counter].count - 1;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomImageCell
        
        cell.selected = false
        
        let img = UIImage(named: images[counter][indexPath.row + 1])
        cell.imageCell.image = img
        
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width :CGFloat = (collectionView.frame.size.width / CGFloat((images[counter].count - 1))) - 20;
        
        return CGSize(width: width, height: collectionView.frame.width - 300)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        counter++
        
        if(counter >= images.count){
            counter = 0
        }
        
        collectionView.reloadData()
        
        playAudioTrack()
    }
    
    func playAudioTrack(){
        
        let sound = images[counter][0]
        
        let soundURL = NSBundle.mainBundle().URLForResource(sound, withExtension: "mp4")
        
        audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        audioPlayer.play()
    }
}
