//
//  DataEntry.swift
//  Phoneme
//
//  Created by donal on 01/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import Parse

// this class is a monster!
class DataEntryViewController: BaseUIViewController, TaskSelectorViewControllerDelegate {

    
    @IBOutlet weak var addNewSchool: UIButton!
    @IBOutlet weak var newSchoolName: UITextField!
    @IBOutlet weak var addSchoolErrorLabel: UILabel!
    
    @IBOutlet weak var schoolsTableView: UITableView!
    
    @IBOutlet weak var newClassName: UITextField!
    @IBOutlet weak var addNewClass: UIButton!
    @IBOutlet weak var addTeacherName: UITextField!
    @IBOutlet weak var classesTableView: UITableView!
    
    @IBOutlet weak var studentIdentifier: UITextField!
    @IBOutlet weak var studentDateOfBirth: UIDatePicker!
    
    @IBOutlet weak var studentGender: UISegmentedControl!
    
    @IBOutlet weak var startTasksForStudent: UIButton!
    
    @IBOutlet weak var studentsTableview: UITableView!
    
    @IBOutlet weak var classesContainer: UIView!
    
    @IBOutlet weak var studentContainer: UIView!
    
    @IBOutlet weak var classContainer: UIView!
    
    @IBOutlet weak var schoolContainer: UIView!
    
    var schools: [SchoolsDataLayer]?
    var classes: [ClassDataLayer]?
    var students: [StudentDataLayer]?
    
    var schoolsData: SchoolDataSource?
    var classesData: ClassesDataSource?
    var studentsData: StudentDataSource?

    
    var selectedSchool: SchoolsDataLayer?
    var selectedClass: ClassDataLayer?
    var selectedStudent: StudentDataLayer = StudentDataLayer.emptyStudent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableRefreshers()
        
        schoolsData = SchoolDataSource(parent: self)
        classesData = ClassesDataSource(parent: self)
        studentsData = StudentDataSource(parent: self)
        
        schoolsTableView.dataSource = schoolsData!
        schoolsTableView.delegate = schoolsData!
        
        classesTableView.dataSource = classesData
        classesTableView.delegate = classesData
        
        studentsTableview.dataSource = studentsData
        studentsTableview.delegate = studentsData
        
        disableContainerView(studentContainer)
        disableContainerView(classContainer)
        setContainerStateAction(schoolContainer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleButtonEnabledStates", name: UITextFieldTextDidChangeNotification, object: nil)
        
        handleButtonEnabledStates()

    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    @IBAction func logoutUser(sender: AnyObject) {
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func setupTableRefreshers(){
        let schoolsRefresher = UIRefreshControl()
        schoolsRefresher.addTarget(self, action: "refreshSchools:", forControlEvents: .ValueChanged)
        schoolsTableView.addSubview(schoolsRefresher)
        
        let classesRefresher = UIRefreshControl()
        classesRefresher.addTarget(self, action: "refreshClasses:", forControlEvents: .ValueChanged)
        classesTableView.addSubview(classesRefresher)
        
        let studentsRefresher = UIRefreshControl()
        studentsRefresher.addTarget(self, action: "refreshStudents:", forControlEvents: .ValueChanged)
        studentsTableview.addSubview(classesRefresher)
    }
    
    func refreshSchools(refreshControl: UIRefreshControl){
        schoolsData?.reloadSchools()
        refreshControl.endRefreshing()
    }
    
    func refreshClasses(refreshControl: UIRefreshControl){
        let schoolId: String = self.selectedSchool!.objectId
        classesData?.reloadClassesForSchool(schoolId)
        refreshControl.endRefreshing()
    }
    
    func refreshStudents(refreshControl: UIRefreshControl){
        if(self.selectedClass == nil){
            return;
        }
        
        let classId: String = self.selectedClass!.objectId
        studentsData!.reloadStudentsForClass(classId)
        refreshControl.endRefreshing()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        schoolsData?.reloadSchools()
    }
    
    @IBAction func dismissKeyboardEndOnExit(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func dismissKeyboard(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func saveNewSchool(sender: UIButton) {
        let name = newSchoolName.text
        
        SchoolsDataLayer.saveNewSchool(name) { (success, error) -> Void in
            if(!success){
                self.showErrorMessage(error, userError: true)
                return
            }
            
            // reload table
            self.newSchoolName.text = ""
            self.schoolsData?.reloadSchools()
            
            self.newSchoolName.resignFirstResponder()
        }
    }
    

    @IBAction func saveNewClass(sender: AnyObject) {
        let schoolId = self.selectedSchool!.objectId
        let className = newClassName.text
        let teacherName = addTeacherName.text
        
        let newClass = ClassDataLayer.new(schoolId, className: className, teacherName: teacherName)
        
        newClass.save { (success, error) -> Void in
            if(!success){
                self.showErrorMessage(error, userError: true)
                return
            }
            
            self.newClassName.text = ""
            self.addTeacherName.text = ""
            
            self.classesData?.reloadClassesForSchool(self.selectedSchool!.objectId)
        }
    }

    @IBAction func saveStudent(sender: AnyObject) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let date = dateFormatter.stringFromDate(studentDateOfBirth.date)
        
        let student = StudentDataLayer.new(self.selectedClass!.objectId, identifier: self.studentIdentifier.text, dateOfBirth: date, gender: studentGender.selectedSegmentIndex == 0 ? "M" : "F")
        
        student.save { (success, error) -> Void in
            
            if(!success){
                self.showErrorMessage(error, userError: true)
                return
            }
            
            self.studentIdentifier.text = ""
            self.studentsData!.reloadStudentsForClass(self.selectedClass!.objectId)
        }
    }
    
    func disableContainerView(container: UIView){
        container.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        container.layer.borderWidth = 0;
        for object in container.subviews{
                let view = object as! UIView
            view.userInteractionEnabled = false
            view.alpha = 0.4
        }
    }
    
    func setContainerStateAction(container: UIView){
        container.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        container.alpha = 1
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.8).CGColor
        for object in container.subviews{
            let view = object as! UIView
            view.userInteractionEnabled = true
            view.alpha = 1
        }
    }
    
    func setContainerViewComplete(container: UIView){
        container.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        container.layer.borderWidth = 1
        container.alpha = 1
        container.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.8).CGColor
        for object in container.subviews{
            let view = object as! UIView
            view.userInteractionEnabled = true
            view.alpha = 0.8
        }
    }
    
    @IBAction func genderChanged(sender: UISegmentedControl) {
            startTasksForStudent.enabled = (!studentIdentifier.text.isEmpty && studentGender.selectedSegmentIndex > -1)
    }
    
    func handleButtonEnabledStates(){
        addNewSchool.enabled = !newSchoolName.text.isEmpty
        addNewClass.enabled = !(newClassName.text.isEmpty || addTeacherName.text.isEmpty)
        startTasksForStudent.enabled = (!studentIdentifier.text.isEmpty && studentGender.selectedSegmentIndex > -1)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "dophonemes")
        {
            if let dest = segue.destinationViewController as? ViewController{
                dest.delegate = self
            }
        }
    }
    
    class SchoolDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
        let parent: DataEntryViewController
        
        init (parent: DataEntryViewController){
            self.parent = parent
        }
        
        func reloadSchools(){
            SchoolsDataLayer.loadSchools { (success, error, schools) -> Void in
                if(!success){
                    self.parent.showErrorMessage(error, userError: true)
                    return
                }
                
                self.parent.schools = schools
                self.parent.schoolsTableView.reloadData()
            }
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return parent.schools?.count ?? 0
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
            cell.textLabel?.text = parent.schools?[indexPath.row].schoolName
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent((indexPath.row % 2 == 0) ? 0.4 : 0.28)
            
            return cell
        }
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            parent.selectedSchool = parent.schools![indexPath.row]
            parent.classesData?.reloadClassesForSchool(parent.selectedSchool!.objectId)
            
            parent.disableContainerView(parent.studentContainer)
            parent.setContainerStateAction(parent.classContainer)
            parent.setContainerViewComplete(parent.schoolContainer)
        }
    }
    
    class ClassesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
        let parent: DataEntryViewController
        
        init (parent: DataEntryViewController){
            self.parent = parent
        }
        
        func reloadClassesForSchool(schoolId: String?){
            
            if(schoolId == nil || schoolId!.isEmpty){
                return
            }
            
            ClassDataLayer.loadClassesForSchool(schoolId!) { (success, error, classes) -> Void in
                
                if(!success){
                    self.parent.showErrorMessage(error, userError: true)
                }
                
                self.parent.classes = classes
                self.parent.classesTableView.reloadData()
            }
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return parent.classes?.count ?? 0
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
            cell.textLabel?.text = parent.classes![indexPath.row].className
            cell.detailTextLabel?.text = parent.classes![indexPath.row].teacherName
            
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent((indexPath.row % 2 == 0) ? 0.4 : 0.28)
            
            return cell
        }
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            parent.selectedClass = parent.classes![indexPath.row]
            
            parent.setContainerStateAction(parent.studentContainer)
            parent.setContainerViewComplete(parent.classContainer)
            parent.setContainerViewComplete(parent.schoolContainer)
            
            parent.studentsData!.reloadStudentsForClass(parent.selectedClass!.objectId)
        }
    }
    
    class StudentDataSource : NSObject, UITableViewDataSource, UITableViewDelegate{
        let parent: DataEntryViewController
        
        init (parent: DataEntryViewController){
            self.parent = parent
        }
        
        func reloadStudentsForClass(classId: String?){
            if(classId == nil || classId!.isEmpty){
                return;
            }
            
            StudentDataLayer.LoadStudentsInClass(classId!, completionBlock: { (success, error, students) -> Void in
                if(!success){
                    self.parent.showErrorMessage(error, userError: false)
                    return
                }
                
                self.parent.students = students
                self.parent.studentsTableview.reloadData()
            })
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return parent.students?.count ?? 0
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! StudentDataTableViewCell
            let student = parent.students![indexPath.row];
            
            cell.identifierLabel.text = student.identifier
            cell.dateOfBirthLabel.text = student.dateOfBirth
            cell.genderLabel.text = student.gender == "M" ? "Male" : "Female"
            cell.isCompletedLabel.text = student.isCompleted ? "Complete" : "Pending"
            
            
            let color =  (!student.isCompleted) ? UIColor.whiteColor() : UIColor.lightGrayColor()
            
            cell.identifierLabel.textColor = color
            cell.dateOfBirthLabel.textColor = color
            cell.genderLabel.textColor = color
            cell.isCompletedLabel.textColor = color
            
            if(student.isCompleted){
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.accessoryType = UITableViewCellAccessoryType.None
            }else{
                cell.selectionStyle = UITableViewCellSelectionStyle.Gray
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            }
            
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent((indexPath.row % 2 == 0) ? 0.4 : 0.28)
            
            return cell
        }
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            self.parent.selectedStudent = parent.students![indexPath.row];
            
            if(!self.parent.selectedStudent.isCompleted)
            {
                self.parent.performSegueWithIdentifier("dophonemes", sender: self.parent)
            }
        }
    }
}
