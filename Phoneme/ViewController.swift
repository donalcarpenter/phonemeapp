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
    
    let familiarizationTask: Task = Task(intro:"FamIntro", title:"Familiarisation", items:
        [TaskItem(audio:"Fam1", images:["", "green-box", ""], correctImage:"green-box"),
            TaskItem(audio:"Fam3", images:["mouse", "seal", "dog"], correctImage:"dog"),
            TaskItem(audio:"Fam4", images:["cat", "bear", "spider"], correctImage:"cat"),
            TaskItem(audio:"Fam5", images:["fly", "bee", "snake"], correctImage:"bee"),
            TaskItem(audio:"Fam6", images:["cow", "pig", "fish"], correctImage:"fish")])
    
    let rhymeOddittyTask : Task = Task(intro: "RhymeIntro", title: "Rhyme Odditty", items:
        [TaskItem(audio: "Rhyme1", images:["cat", "hat", "boat", "goat"], correctImage:"cat", requireResponse:false),
            TaskItem(audio:"Rhyme2", images: ["fish", "dish", "ball"], correctImage:"ball", requireResponse:false),
            TaskItem(audio:"Rhyme3", images:["pig", "hat", "bat"], correctImage: "pig", requireResponse:false),
            TaskItem(audio:"Rhyme4", images:["cat", "mat", "bus"], correctImage: "bus"),
            TaskItem(audio:"Rhyme5", images:["peg", "doll", "leg"], correctImage: "doll"),
            TaskItem(audio:"Rhyme6", images:["saw", "toe", "bow"], correctImage: "saw"),
            TaskItem(audio:"Rhyme7", images:["sand", "hand", "cup"], correctImage: "cup"),
            TaskItem(audio:"Rhyme8", images:["hen", "car", "pen"], correctImage: "car"),
            TaskItem(audio:"Rhyme9", images:["dog", "book", "hook"], correctImage: "dog"),
            TaskItem(audio:"Rhyme10", images:["bun", "sun", "kite"], correctImage: "kite"),
            TaskItem(audio:"Rhyme11", images:["tent", "lock", "sock"], correctImage: "tent"),
            TaskItem(audio:"Rhyme12", images:["shell", "duck", "bell"], correctImage: "duck"),
            TaskItem(audio:"Rhyme13", images:["ring", "sing", "lamb"], correctImage: "lamb")
        ])
    
    let initialPhonemeTask = Task(intro:"InitialPhonemeIntro", title: "Initial Phoneme Identity Task", items:
        [   InitialPhonemeTaskItem(firstImage: "dog", audio: "InitialPhoneme1", images: ["moon", "duck", "whale"], correctImage: "duck", requireResponse: true, outro:"InitialPhoneme2"),
            InitialPhonemeTaskItem(firstImage: "dog", audio: "InitialPhoneme3", images: ["horse", "rope", "door"], correctImage: "door", requireResponse: true, outro:"InitialPhoneme4"),
            InitialPhonemeTaskItem(firstImage: "mouse", audio: "InitialPhoneme5", images: ["doll", "bear", "milk"], correctImage: "milk"),
            InitialPhonemeTaskItem(firstImage: "mouse", audio: "InitialPhoneme6", images: ["mat", "dog", "book"], correctImage: "mat"),
            InitialPhonemeTaskItem(firstImage: "seal", audio: "InitialPhoneme7", images: ["bee", "sun", "tent"], correctImage: "sun"),
            InitialPhonemeTaskItem(firstImage: "seal", audio: "InitialPhoneme8", images: ["saw", "tie", "hook"], correctImage: "saw"),
            InitialPhonemeTaskItem(firstImage: "cat", audio: "InitialPhoneme9", images: ["bus", "kite", "arm"], correctImage: "kite"),
            InitialPhonemeTaskItem(firstImage: "cat", audio: "InitialPhoneme10", images: ["comb", "dish", "soap"], correctImage: ""),
            InitialPhonemeTaskItem(firstImage: "bee", audio: "InitialPhoneme11", images: ["cat", "leg", "ball"], correctImage: "ball"),
            InitialPhonemeTaskItem(firstImage: "bee", audio: "InitialPhoneme12", images: ["car", "boat", "shoe"], correctImage: "boat"),
            InitialPhonemeTaskItem(firstImage: "fish", audio: "InitialPhoneme13", images: ["foot", "hat", "pig"], correctImage: "foot"),
            InitialPhonemeTaskItem(firstImage: "fish", audio: "InitialPhoneme14", images: ["duck", "bell", "fire"], correctImage: "fire")
        ])
    
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
            self.task = familiarizationTask;
            dest.delegate = self;
            
            return
        }
        
        if(segue.identifier == "rhymeoddity"){
            let dest = segue.destinationViewController as! SingleRowImageTask
            self.task = rhymeOddittyTask;
            dest.delegate = self;
            
            return
        }
        
        if(segue.identifier == "initialphoneme"){
            let dest = segue.destinationViewController as! InitialPhonemeViewController
            self.task = initialPhonemeTask
            dest.delegate = self
            return
        }
    }
}

