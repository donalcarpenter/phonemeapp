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
        collectionView.reloadData()
        
        var initPhonemeTask = task?.items[counter] as! InitialPhonemeTaskItem
        
        topImage.image = UIImage(named: initPhonemeTask.firstImage)
    }
    
    override func processResults() {
        // noop right now...
    }
}
