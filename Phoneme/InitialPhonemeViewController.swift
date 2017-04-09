//
//  InitialPhonemeViewController.swift
//  Phoneme
//
//  Created by donal on 25/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class InitialPhonemeViewController: TaskViewController{
    

    @IBOutlet weak var topImage: UIImageView!
    
    override func loadTaskItems() {
    
        let initPhonemeTask = task?.items[counter] as! InitialPhonemeTaskItem
        
        collectionView.isHidden = true;

        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(initPhonemeTask.delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: { () -> Void in
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
        })
        

        topImage.image = UIImage(named: initPhonemeTask.firstImage)
    }
    
    override func setTaskItemOptionView(_ view: UIView, task: TaskItem, index: Int) {
        
        if let img = view as? UIImageView
        {
            img.image = UIImage(named: task.images[index])
        }
        
    }
}
