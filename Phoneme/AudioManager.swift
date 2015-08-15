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

    static var nextCompliment = Int(arc4random_uniform(3))
    static var count = 0
    static let complimentsAudio = ["Comp1", "Comp2", "Comp3", "Comp4", "Comp5"]
    
    let postSynchronousPlaybackQueue = Queue<NSOperation>()

    
    func playComplimentThenContinue(completionBlock: () -> Void){
        if(AudioManager.nextCompliment == AudioManager.count++){
            AudioManager.nextCompliment += Int(arc4random_uniform(4) + 1)
            
            let audiotoPlay = AudioManager.complimentsAudio[Int(arc4random_uniform(UInt32(AudioManager.complimentsAudio.count)))]
            
            playAudioFrom(audiotoPlay, completionBlock: completionBlock)
        }
        else{
            completionBlock()
        }
    }
    
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
