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
    
    func uploadResults(results: [TaskResultRawItem])
}

class SingleRowImageTask: TaskViewController {
    
    override func loadTaskItems(){
        super.collectionView.reloadData()
    }
    
    override func setTaskItemOptionView(view: UIView, task: TaskItem, index: Int) {
        
        if let img = view as? UIImageView
        {
            img.image = UIImage(named: task.images[index])
        }
        
    }
}
