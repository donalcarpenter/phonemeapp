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
        
        collectionView.hidden = true;
        
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW, Int64(initPhonemeTask.delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                self.collectionView.hidden = false
                self.collectionView.reloadData()
        })
        
    }
    
    override func setTaskItemOptionView(view: UIView, task: TaskItem, index: Int) {
        
        if let lbl = view as? UILabel
        {
            lbl.text = task.images[index]
            lbl.font = UIFont(name: "DidactGothic", size: 45)
        }
        
    }
}
