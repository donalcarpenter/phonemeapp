//
//  CustomLetterCell.swift
//  Phoneme
//
//  Created by donal on 08/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class CustomLetterCell: UICollectionViewCell, TaskItemOptionCell {
    @IBOutlet weak var imageCell: UILabel!
    
    var name: String?
    
    func presentationView() -> UIView {
        
        return imageCell
    }
}
