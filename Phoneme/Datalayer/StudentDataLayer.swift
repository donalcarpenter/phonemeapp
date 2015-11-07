//
//  StudentDataLayer.swift
//  Phoneme
//
//  Created by donal on 01/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import Parse

class StudentDataLayer: NSObject {
    let studentId: String
    let classId: String
    let identifier: String
    let dateOfBirth: String
    let gender: String
    var isCompleted = false
    
    static var emptyStudent: StudentDataLayer = StudentDataLayer(studentId: "", classId: "", identifier: "", dateOfBirth: "", gender: "")
    
    init (studentId: String, classId: String, identifier: String, dateOfBirth: String, gender: String){
        self.studentId = studentId
        self.classId = classId
        self.identifier = identifier
        self.dateOfBirth = dateOfBirth
        self.gender = gender
    }
    
    class func new(classId: String, identifier: String, dateOfBirth: String, gender: String) -> StudentDataLayer {
        return StudentDataLayer(studentId: "", classId: classId, identifier: identifier, dateOfBirth: dateOfBirth, gender: gender)
    }
    
    static func saveTaskResult(result: TaskResult, completionBlock: (success: Bool, error: String) -> Void){
        
        let query = PFQuery(className: "student")
        
        query.getObjectInBackgroundWithId(result.studentId, block: { (student: PFObject?, err: NSError?) -> Void in
            if(err != nil){
                completionBlock(success: false, error: "\(err)")
                return
            }
            
            let key = result.taskTitle.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            student![key] = result.correctAnswers
        
            
            student?.saveInBackgroundWithBlock({ (success: Bool, err: NSError?) -> Void in
                if(!success)
                {
                    completionBlock(success: false, error: "\(err)")
                }
                else{
                    completionBlock(success: true, error: "")
                    self.saveRawData(student!, key:key, rawResults:result.rawData)
                }
            })
        })
    }

    static func setStudentCompleted(studentId: String, completionBlock: (success: Bool, error: String) -> Void){
        
        let query = PFQuery(className: "student")
        
        query.getObjectInBackgroundWithId(studentId, block: { (student: PFObject?, err: NSError?) -> Void in
            if(err != nil){
                completionBlock(success: false, error: "\(err)")
                return
            }
        
            student!["isCompleted"] = true
            
            student?.saveInBackgroundWithBlock({ (success: Bool, err: NSError?) -> Void in
                if(!success)
                {
                    completionBlock(success: false, error: "\(err)")
                }
                else{
                    completionBlock(success: true, error: "")
                }
            })
        })
    }
    
    static func saveRawData(student: PFObject, key: String, rawResults: [TaskResultRawItem]?){
        
        if(rawResults == nil){
            return
        }
        
        var rawData = [NSDictionary]()
        
        for data in rawResults!{
            let dict : [String: AnyObject] =
            ["index": data.index, "correctAnswer": data.correctAnswer, "givenAnswer" : data.givenAnswer]
            
            rawData.append(dict);
        }
        
        let query = PFQuery(className: "rawResults")
        query.whereKey("task", equalTo: key)
        query.whereKey("student", equalTo: student)
        
        query.getFirstObjectInBackgroundWithBlock { (pfResults:PFObject?, err:NSError?) -> Void in
            if let data = pfResults as PFObject!
            {
                data["results"] = rawData
                data.saveInBackgroundWithBlock(nil)
                
            }else{
                let data = PFObject(className: "rawResults")
                data["task"] = key
                data["student"] = student
                data["results"] = rawData
                data.saveInBackgroundWithBlock(nil)
            }
        }
    }
    
    func loadTasks(){
    }
    
    func save(completionBlock: (success: Bool, error: String) -> Void){
        let dupeCheck = PFQuery(className: "student")
        dupeCheck.whereKey("classId", equalTo:classId)
        dupeCheck.whereKey("identifier", equalTo:identifier)
        
        dupeCheck.findObjectsInBackgroundWithBlock { (objs: [AnyObject]?, err:NSError?) -> Void in
            
            if(err != nil){
                completionBlock(success: false, error: "\(err)")
                
                return
            }
            
            if(objs?.count > 0){
                completionBlock(success: false, error: "There is already a student with the identifier \(self.identifier) in this class")
                
                return
            }
            
            let save = PFObject(className: "student")
            save["classId"] = self.classId
            save["identifier"] = self.identifier
            save["dateOfBirth"] = self.dateOfBirth
            save["gender"] = self.gender
            save["isCompleted"] = self.isCompleted
            
            save.saveInBackgroundWithBlock({ (success: Bool, err: NSError?) -> Void in
                if(!success || err != nil){
                    completionBlock(success: false, error: "\(err)")
                    
                    return
                }
                
                completionBlock(success: true, error: "")
            })
        }
    }
    
    class func LoadStudentsInClass(classId: String, completionBlock: (success: Bool, error: String, students: [StudentDataLayer]?) -> Void){
        let query = PFQuery(className: "student")
        query.whereKey("classId", equalTo: classId)
        query.orderByAscending("identifier")
        
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, err:NSError?) -> Void in
            
            var results = [StudentDataLayer]()
            
            if(err != nil){
                completionBlock(success: false, error: "\(err)", students: results)
                return
            }
            
            for pfobj in objects! as! [PFObject]{
                let student = StudentDataLayer(studentId: pfobj.objectId!, classId: pfobj["classId"] as! String, identifier: pfobj["identifier"] as! String, dateOfBirth: pfobj["dateOfBirth"] as! String, gender: pfobj["gender"] as! String)
                
                if let completed = pfobj["isCompleted"] as? Bool{
                    student.isCompleted = completed
                }else{
                    student.isCompleted = false
                }
                
                results.append(student)
            }
            
            completionBlock(success: true, error: "", students: results)
        }
    }
}
