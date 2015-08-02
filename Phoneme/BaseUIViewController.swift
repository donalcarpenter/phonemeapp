//
//  BaseUIViewController.swift
//  Phoneme
//
//  Created by donal on 02/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let bgimg = UIImage(named: "background-blur")
        let bgimgw = UIImageView(frame: self.view.frame)
        bgimgw.image = bgimg
        
        self.view.insertSubview(bgimgw, atIndex: 0)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    func showErrorMessage(message: String, userError: Bool){
        
        let alertController = UIAlertController(title: "problems...", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion: nil);
    }
}
