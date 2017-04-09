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
        TaskFactory.blendingTask.taskTitle: "singlerowimage",
        TaskFactory.deletionTask.taskTitle: "initialphoneme",
    ]
    
    @IBOutlet weak var tasks: UITableView!
    @IBOutlet weak var showCompleted: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(delegate == nil){
            showErrorMessage("woops, something has gone badly wrong and results will not be saved.  If i were you i'd kill the app and start again...", userError: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        repopulateTableView()
    }
    
    
    @IBAction func back(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskbutton")!;
        let title = tasksDatasource[indexPath.row].taskTitle
        cell.textLabel?.text = title;
        
        if(shouldIndexPathBeSelectable(indexPath)){
            cell.selectionStyle = .default
            cell.textLabel?.isEnabled = true;
        }else{
            cell.selectionStyle = .gray
            cell.textLabel?.isEnabled = false;
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return shouldIndexPathBeSelectable(indexPath) ? indexPath : nil;
    }
    
    func shouldIndexPathBeSelectable(_ indexPath: IndexPath) -> Bool{
        let title = tasksDatasource[indexPath.row].taskTitle
        if(self.delegate.selectedStudent.results.contains(taskKeyFromTitle(title))){
            return false;
        }
        
        if(!self.delegate.selectedStudent.results.contains("Familiarisation") && tasksDatasource[indexPath.row] != TaskFactory.familiarisation){
            return false
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.task = tasksDatasource[indexPath.row];
        
        let segue = self.configuredSegues[task.taskTitle]!
        
        performSegue(withIdentifier: segue, sender: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksDatasource.count
    }

    func uploadResults(_ results: [TaskResultRawItem]){
        
        var correct = 0;
        
        for t in results{
            if t.correctAnswer == t.givenAnswer{
                correct += 1
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
        addTaskToDatasourceIfNotCompleted(TaskFactory.blendingTask)
        addTaskToDatasourceIfNotCompleted(TaskFactory.deletionTask)
        
        self.tasks.reloadData()
    }
    
    func addTaskToDatasourceIfNotCompleted(_ t: Task){
        
        let key = taskKeyFromTitle(t.taskTitle)
        
        if(!showCompleted.isOn && delegate.selectedStudent.results.contains(key)){
           return
        }
        
        tasksDatasource.append(t)
    }
    
    @IBAction func showCompletedChanged(_ sender: AnyObject) {
        repopulateTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! TaskViewController
        dest.delegate = self;
    }
    
    func taskKeyFromTitle(_ title: String) -> String{
        return title.replacingOccurrences(of: " ", with: "_", options: NSString.CompareOptions.literal, range: nil);
    }
}
