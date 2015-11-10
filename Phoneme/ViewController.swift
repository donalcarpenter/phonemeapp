//
//  ViewController.swift
//  Phoneme
//
//  Created by donal on 23/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import Parse

protocol TaskSelectorViewControllerDelegate{
    var selectedStudent : StudentDataLayer { get }
    func refreshStudentState()
}

class ViewController: BaseUIViewController, ImageCollectionViewControllerDelegate {
    
    @IBOutlet weak var FamiliarisationButton: UIButton!
    @IBOutlet weak var rhymeOddityButton: UIButton!
    @IBOutlet weak var initialPhonemeButton: UIButton!
    @IBOutlet weak var finalPhonemeButton: UIButton!
    @IBOutlet weak var letterNameRecogButton: UIButton!
    @IBOutlet weak var letterSoundButton: UIButton!
    @IBOutlet weak var singleWordButton: UIButton!
    
    var selectedButton: UIButton?
    
    var task :Task = Task.emptyTask
    var delegate: TaskSelectorViewControllerDelegate?
    
    var outstandingTasks: Int = TaskFactory.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgimgO = UIImage(named: "background")
        let bgimgOw = UIImageView(frame: self.view.frame)
        bgimgOw.image = bgimgO
        
        self.view.insertSubview(bgimgOw, atIndex: 1)
        
        UIView.animateWithDuration(1.5){
            bgimgOw.alpha = 0
        }
        
        setEnableStateOnNonFamiliarisationButtons(true)
        
        if(delegate == nil){
            showErrorMessage("woops, something has gone badly wrong and results will not be saved.  If i were you i'd kill the app and start again...", userError: false)
        }
    }
    
    func setEnableStateOnNonFamiliarisationButtons(enabled:Bool){
        rhymeOddityButton.enabled = enabled
        initialPhonemeButton.enabled = enabled
        finalPhonemeButton.enabled = enabled
        letterNameRecogButton.enabled = enabled
        letterSoundButton.enabled = enabled
        singleWordButton.enabled = enabled
    }
    
    @IBAction func returnToDataView(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func trackSelectedButton(sender: UIButton) {
        selectedButton = sender
    }

    func uploadResults(results: [TaskResultRawItem]){
        
        var correct = 0;
        
        for t in results{
            if t.correctAnswer == t.givenAnswer{
                correct++
            }
        }

            let result = TaskResult(studentId: delegate!.selectedStudent.studentId, title: self.task.taskTitle, count: results.count, correct: correct)
            
            result.rawData = results
            
            delegate!.selectedStudent.saveTaskResult(result, completionBlock: { (success, error) -> Void in
                if(!success){
                    self.showErrorMessage("well this is embarassing. we could not send the results to the remote server. Please take note on task \(self.task.taskTitle) this participant got \(correct) answers right. the error received is \(error)", userError: false)
                    
                    
                    return
                }
                else
                {
                    if(self.task == TaskFactory.familiarisation){
                        if(results.count - correct >= 3){
                            
                            let audioManager = AudioManager()
                            audioManager.playAudioFrom("FamiliarisationError")
                            
                            self.FamiliarisationButton.enabled = true;
                            self.setEnableStateOnNonFamiliarisationButtons(false)
                            
                        }else{
                            
                            self.setEnableStateOnNonFamiliarisationButtons(true)
                            self.FamiliarisationButton.enabled = false;
                            
                            self.outstandingTasks--;
                        }
                    }
                    else
                    {
                        if let buttonToDisable = self.selectedButton
                        {
                            buttonToDisable.enabled = false
                        }
                        
                        self.outstandingTasks--;
                    }
                    
                    /*
                    if(self.outstandingTasks == 0){
                        StudentDataLayer.setStudentCompleted(result.studentId, completionBlock: { (success, error) -> Void in
                            if(success){
                                // we need to do something here...
                                self.delegate!.refreshStudentState()
                                    self.navigationController?. popViewControllerAnimated(true)
                            }else{
                                self.showErrorMessage("The student is complete and all task results have been saved, but something went wrong. Check to see if the student isComplete attribute is true for \(result.studentId)", userError: false)
                            }
                        })
                    }
                    */
                }
            })
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
        
        if(segue.identifier == "lettername"){
            let dest = segue.destinationViewController as! LetterNameRecognitionViewController
            self.task = TaskFactory.letterNameTask
            dest.delegate = self
            return
        }
        
        if(segue.identifier == "lettersound"){
            let dest = segue.destinationViewController as! LetterNameRecognitionViewController
            self.task = TaskFactory.letterSoundTask
            dest.delegate = self
            return
        }
        
        if(segue.identifier == "singleword"){
            let dest = segue.destinationViewController as! WordReadingTaskViewController
            self.task = TaskFactory.singleWordTask
            dest.delegate = self
            return
        }
    }
}

