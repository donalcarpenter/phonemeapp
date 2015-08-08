//
//  AudioManager.swift
//  Phoneme
//
//  Created by donal on 25/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import AVFoundation
var audioPlayer = AVAudioPlayer()

class AudioManager: NSObject, AVAudioPlayerDelegate {

    let postSynchronousPlaybackQueue = Queue<NSOperation>()
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        while(!postSynchronousPlaybackQueue.isEmpty()){
            NSOperationQueue.mainQueue().addOperation(postSynchronousPlaybackQueue.dequeue()!)
        }
    }
    
    func playAudioFrom(source: String){
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        let soundURL = NSBundle.mainBundle().URLForResource(source, withExtension: "mp4")
        audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        audioPlayer.delegate = nil
        audioPlayer.play()
    }
    
    func playAudioFrom(source: String, completionBlock: () -> Void){    
        let soundURL = NSBundle.mainBundle().URLForResource(source, withExtension: "mp4")
        postSynchronousPlaybackQueue.enqueue(NSBlockOperation(block: completionBlock))
        audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        audioPlayer.delegate = self
        audioPlayer.play()
    }
    
    func stop(){
        audioPlayer.stop()
    }
}
