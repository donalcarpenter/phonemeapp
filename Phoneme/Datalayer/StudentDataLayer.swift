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
    let entity: PFObject
    let studentId: String
    let classId: String
    let identifier: String
    let dateOfBirth: String
    let gender: String
    var isCompleted = false
    var results = Set<String>()
    
    static var emptyStudent: StudentDataLayer = StudentDataLayer.new("", identifier: "", dateOfBirth: "", gender: "")
    
    init (entity: PFObject){
        self.studentId = entity.objectId ?? ""
        self.classId = entity["classId"] as! String
        self.identifier = entity["identifier"] as! String
        self.dateOfBirth = entity["dateOfBirth"] as! String
        self.gender = entity["gender"] as! String
        
        self.entity = entity;
    }
    
    class func new(classId: String, identifier: String, dateOfBirth: String, gender: String) -> StudentDataLayer {
        let entity = PFObject(className: "student")
        entity["classId"] = classId
        entity["identifier"] = identifier
        entity["dateOfBirth"] = dateOfBirth
        entity["gender"] = gender
        
        return StudentDataLayer(entity: entity)
    }
    
    func saveTaskResult(result: TaskResult, completionBlock: (success: Bool, error: String) -> Void){
        
        let student = entity
        
        let key = result.taskTitle.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        student[key] = result.correctAnswers
        
        student.saveInBackgroundWithBlock({ (success: Bool, err: NSError?) -> Void in
            if(!success)
            {
                completionBlock(success: false, error: "\(err)")
            }
            else{
                completionBlock(success: true, error: "")
                self.saveRawData(student, key:key, rawResults:result.rawData)
            }
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
    
    func saveRawData(student: PFObject, key: String, rawResults: [TaskResultRawItem]?){
        
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
    
    func loadTasks(completionBlock: (success: Bool, error: String) -> Void){
        let query = PFQuery(className: "rawResults")
        query.whereKey("student", equalTo: self.entity)
        
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, err:NSError?) -> Void in
            
            if(err != nil){
                completionBlock(success: false, error: "\(err)")
                return
            }
            
            for pfobj in objects! as! [PFObject]{
                if let task = pfobj["task"] as? String{
                    if(!self.results.contains(task)){
                        self.results.insert(task)
                    }
                }
            }
            
            completionBlock(success: true, error: nil)
        }
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
            
            let save = self.entity
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
                let student = StudentDataLayer(entity: pfobj)
                
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
