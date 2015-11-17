//
//  TaskSelectionTableViewCell.swift
//  Phoneme
//
//  Created by donal on 16/11/2015.
//  Copyright © 2015 donal. All rights reserved.
//

import UIKit

class TaskSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    var seguetoperform: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonTapped(sender: AnyObject) {
        
        
    }
}
