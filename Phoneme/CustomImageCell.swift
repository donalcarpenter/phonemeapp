//
//  CustomImageCell.swift
//  Phoneme
//
//  Created by donal on 23/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

protocol TaskItemOptionCell : class{
    var name : String? { get set }
    func presentationView() -> UIView
}

class CustomImageCell: UICollectionViewCell, TaskItemOptionCell {

    @IBOutlet weak var imageCell: UIImageView!
    
    var name: String?
    
    func presentationView() -> UIView {
        return imageCell!
    }
}
