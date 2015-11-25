//
//  SegmentationViewController.swift
//  Phoneme
//
//  Created by donal on 25/11/2015.
//  Copyright © 2015 donal. All rights reserved.
//

import UIKit

class SegmentationViewController: TaskViewController {

    @IBOutlet weak var topImage: UIImageView!
    
    override func loadTaskItems() {
        
        let t = task?.items[counter] as! SegmentationTaskItem
        
        
        topImage.image = UIImage(named: t.image)
    }
    
    override func setTaskItemOptionView(view: UIView, task: TaskItem, index: Int) {
        
        if let img = view as? UIImageView
        {
            img.image = UIImage(named: task.images[index])
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    
        
    }

}
