//
//  SingleRowImageTask.swift
//  Phoneme
//
//  Created by donal on 25/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer1 = AVAudioPlayer()

protocol ImageCollectionViewControllerDelegate{
    var task : Task { get }
    //var player: AudioManager { get }
}

class SingleRowImageTask: TaskViewController {
    
    override func loadTask(){
        super.collectionView.reloadData()
    }
    
    override func processResults(){
        // noop
    }
}
