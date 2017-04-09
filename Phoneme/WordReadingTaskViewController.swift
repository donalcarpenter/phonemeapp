//
//  WordReadingTaskViewController.swift
//  Phoneme
//
//  Created by donal on 08/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class WordReadingTaskViewController: TaskViewController
{

    @IBOutlet weak var imageforWord: UIImageView!
    
    override func loadTaskItems() {
        
        let initPhonemeTask = task?.items[counter] as! InitialPhonemeTaskItem
        let img = UIImage(named: initPhonemeTask.firstImage)
        
        imageforWord.image = img
        
        collectionView.isHidden = true;
        
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(initPhonemeTask.delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: { () -> Void in
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
        })
        
    }
    
    override func setTaskItemOptionView(_ view: UIView, task: TaskItem, index: Int) {
        
        if let lbl = view as? UILabel
        {
            lbl.text = task.images[index]
            lbl.font = UIFont(name: "DidactGothic", size: 45)
        }
        
    }
}
