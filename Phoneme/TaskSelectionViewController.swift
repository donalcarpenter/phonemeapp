//
//  TaskSelectionViewController.swift
//  Phoneme
//
//  Created by donal on 16/11/2015.
//  Copyright © 2015 donal. All rights reserved.
//

import UIKit

class TaskSelectionViewController: BaseUIViewController, UITableViewDataSource, UITableViewDelegate, ImageCollectionViewControllerDelegate {

    var delegate: TaskSelectorViewControllerDelegate!
    var task :Task = Task.emptyTask
    var tasksDatasource = [Task]()
    
    var configuredSegues: [String:String] =
    [
        TaskFactory.rhymeOddittyTask.taskTitle: "singlerowimage",
        TaskFactory.initialPhonemeTask.taskTitle: "initialphoneme",
        TaskFactory.familiarisation.taskTitle: "singlerowimage",
        TaskFactory.finalPhonemeTask.taskTitle: "singlerowimage",
        TaskFactory.letterNameTask.taskTitle: "letterrecognition",
        TaskFactory.letterSoundTask.taskTitle: "letterrecognition",
        TaskFactory.singleWordTask.taskTitle: "wordrecognition",
    ]
    
    @IBOutlet weak var tasks: UITableView!
    @IBOutlet weak var showCompleted: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(delegate == nil){
            showErrorMessage("woops, something has gone badly wrong and results will not be saved.  If i were you i'd kill the app and start again...", userError: false)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        repopulateTableView()
    }
    
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskbutton")!;
        let title = tasksDatasource[indexPath.row].taskTitle
        cell.textLabel?.text = title;
        
        if(shouldIndexPathBeSelectable(indexPath)){
            cell.selectionStyle = .Default
            cell.textLabel?.enabled = true;
        }else{
            cell.selectionStyle = .Gray
            cell.textLabel?.enabled = false;
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        return shouldIndexPathBeSelectable(indexPath) ? indexPath : nil;
    }
    
    func shouldIndexPathBeSelectable(indexPath: NSIndexPath) -> Bool{
        let title = tasksDatasource[indexPath.row].taskTitle
        if(self.delegate.selectedStudent.results.contains(taskKeyFromTitle(title))){
            return false;
        }
        
        if(!self.delegate.selectedStudent.results.contains("Familiarisation") && tasksDatasource[indexPath.row] != TaskFactory.familiarisation){
            return false
        }
        
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.task = tasksDatasource[indexPath.row];
        
        let segue = self.configuredSegues[task.taskTitle]!
        
        performSegueWithIdentifier(segue, sender: tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksDatasource.count
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
                        
                    }
                }
            }
            
            self.repopulateTableView()
        })
    }
    
    func repopulateTableView(){
        
        tasksDatasource.removeAll()
        
        addTaskToDatasourceIfNotCompleted(TaskFactory.familiarisation)
        addTaskToDatasourceIfNotCompleted(TaskFactory.rhymeOddittyTask)
        addTaskToDatasourceIfNotCompleted(TaskFactory.initialPhonemeTask)
        addTaskToDatasourceIfNotCompleted(TaskFactory.finalPhonemeTask)
        addTaskToDatasourceIfNotCompleted(TaskFactory.letterNameTask)
        addTaskToDatasourceIfNotCompleted(TaskFactory.letterSoundTask)
        addTaskToDatasourceIfNotCompleted(TaskFactory.singleWordTask)
        
        
        self.tasks.reloadData()
    }
    
    func addTaskToDatasourceIfNotCompleted(t: Task){
        
        let key = taskKeyFromTitle(t.taskTitle)
        
        if(!showCompleted.on && delegate.selectedStudent.results.contains(key)){
           return
        }
        
        tasksDatasource.append(t)
    }
    
    @IBAction func showCompletedChanged(sender: AnyObject) {
        repopulateTableView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! TaskViewController
        dest.delegate = self;
    }
    
    func taskKeyFromTitle(title: String) -> String{
        return title.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.LiteralSearch, range: nil);
    }
}
