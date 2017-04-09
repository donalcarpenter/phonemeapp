//
//  BaseUIViewController.swift
//  Phoneme
//
//  Created by donal on 02/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {

    var showBackgroundBlur = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(showBackgroundBlur){
            let bgimg = UIImage(named: "background-blur")
            let bgimgw = UIImageView(frame: self.view.frame)
            bgimgw.image = bgimg
            
            self.view.insertSubview(bgimgw, at: 0)
        }
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func showErrorMessage(_ message: String, userError: Bool){
        
        let alertController = UIAlertController(title: "problems...", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil);
    }
}
