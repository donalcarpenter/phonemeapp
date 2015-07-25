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
    
    let familiarizationTask: Task = Task(intro:"Intro", title:"Familiarisation", items:[TaskItem(audio:"Fam1", images:["green-box"], correctImage:"green-box"),
    TaskItem(audio:"Fam3", images:["mouse", "seal", "dog"], correctImage:"dog"),
    TaskItem(audio:"Fam4", images:["cat", "bear", "spider"], correctImage:"cat"),
    TaskItem(audio:"Fam5", images:["fly", "bee", "snake"], correctImage:"bee"),
    TaskItem(audio:"Fam6", images:["cow", "pig", "fish"], correctImage:"fish")])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "familiarization"){
            let dest = segue.destinationViewController as! SingleRowImageTask
            self.task = familiarizationTask;
            dest.delegate = self;
        }
    }
}

