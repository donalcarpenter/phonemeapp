//
//  ViewController.swift
//  Phoneme
//
//  Created by donal on 23/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ImageCollectionViewControllerDelegate {
    
    @IBOutlet weak var FamiliarisationButton: UIButton!
    
    var task :Task = Task.emptyTask
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        let bgimg = UIImage(named: "background-blur")
        let bgimgw = UIImageView(frame: self.view.frame)
        bgimgw.image = bgimg
        
        self.view.insertSubview(bgimgw, atIndex: 0)
        
        let bgimgO = UIImage(named: "background")
        let bgimgOw = UIImageView(frame: self.view.frame)
        bgimgOw.image = bgimgO
        
        self.view.insertSubview(bgimgOw, atIndex: 1)
        
        UIView.animateWithDuration(1.5){
            bgimgOw.alpha = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "familiarization"){
            let dest = segue.destinationViewController as! SingleRowImageTask
            self.task = TaskFactory.familiarisation;
            dest.delegate = self;
            
            return
        }
        
        if(segue.identifier == "rhymeoddity"){
            let dest = segue.destinationViewController as! SingleRowImageTask
            self.task = TaskFactory.rhymeOddittyTask;
            dest.delegate = self;
            
            return
        }
        
        if(segue.identifier == "initialphoneme"){
            let dest = segue.destinationViewController as! InitialPhonemeViewController
            self.task = TaskFactory.initialPhonemeTask
            dest.delegate = self
            return
        }
        
        if(segue.identifier == "finalphoneme"){
            let dest = segue.destinationViewController as! SingleRowImageTask
            self.task = TaskFactory.finalPhonemeTask
            dest.delegate = self
            return
        }
    }
}

