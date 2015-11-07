//
//  LetterNameRecognitionViewController.swift
//  Phoneme
//
//  Created by donal on 08/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class LetterNameRecognitionViewController: TaskViewController {

    override func loadTaskItems(){
        super.collectionView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        rows = 2
        
        super.viewWillAppear(animated)
        
    }
    
    override func setTaskItemOptionView(view: UIView, task: TaskItem, index: Int) {
        if let lbl = view as? UILabel
        {
            lbl.text = task.images[index]
            lbl.font = UIFont(name: "DidactGothic", size: 80)
        }
    }
    
    override func itemWasSelected(view: UIView, task: TaskItem, index: Int) {
        if let _ = view as? UILabel
        {
            //lbl.textColor = UIColor.greenColor()
            
            //UIView.animateWithDuration(0.2, animations: { () -> Void in
            //    lbl.textColor = UIColor.blackColor()
            //})
        }
    }
    
}
