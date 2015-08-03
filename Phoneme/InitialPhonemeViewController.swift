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
    
    override func loadTask() {
    
        var initPhonemeTask = task?.items[counter] as! InitialPhonemeTaskItem
        
        collectionView.hidden = true;

        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW, Int64(initPhonemeTask.delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                self.collectionView.hidden = false
                self.collectionView.reloadData()
        })
        

        topImage.image = UIImage(named: initPhonemeTask.firstImage)
    }
}
