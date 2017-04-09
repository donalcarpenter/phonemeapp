//
//  StudentDataLayer.swift
//  Phoneme
//
//  Created by donal on 01/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import Parse
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


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
    
    class func new(_ classId: String, identifier: String, dateOfBirth: String, gender: String) -> StudentDataLayer {
        let entity = PFObject(className: "student")
        entity["classId"] = classId
        entity["identifier"] = identifier
        entity["dateOfBirth"] = dateOfBirth
        entity["gender"] = gender
        
        return StudentDataLayer(entity: entity)
    }
    
    func saveTaskResult(_ result: TaskResult, completionBlock: @escaping (_ success: Bool, _ error: String) -> Void){
        
        let student = entity
        
        let key = result.taskTitle.replacingOccurrences(of: " ", with: "_", options: NSString.CompareOptions.literal, range: nil)
        
        student[key] = result.correctAnswers
        
        results.insert(key)
        
        student.saveInBackground(block: { (success, err) -> Void in
            if(!success)
            {
                completionBlock(false, "\(err)")
                self.results.remove(key)
            }
            else{
                completionBlock(true, "")
                self.saveRawData(student, key: key, rawResults: result.rawData)
            }
        })
    }

    static func setStudentCompleted(_ studentId: String, completionBlock: @escaping (_ success: Bool, _ error: String) -> Void){
        
        let query = PFQuery(className: "student")
        
        query.getObjectInBackground(withId: studentId, block: { (student, err) -> Void in
            if(err != nil){
                completionBlock(false, "\(err)")
                return
            }
        
            student!["isCompleted"] = true
            
            student?.saveInBackground(block: { (success, err) -> Void in
                if(!success)
                {
                    completionBlock(false, "\(err)")
                }
                else{
                    completionBlock(true, "")
                }
            })
        })
    }
    
    func saveRawData(_ student: PFObject, key: String, rawResults: [TaskResultRawItem]?){
        
        if(rawResults == nil){
            return
        }
        
        var rawData = [NSDictionary]()
        
        for data in rawResults!{
            let dict : [String: AnyObject] =
            ["index": data.index as AnyObject, "correctAnswer": data.correctAnswer as AnyObject, "givenAnswer" : data.givenAnswer as AnyObject]
            
            rawData.append(dict as NSDictionary);
        }
        
        let query = PFQuery(className: "rawResults")
        query.whereKey("task", equalTo: key)
        query.whereKey("student", equalTo: student)
        
        query.getFirstObjectInBackground { (pfResults, err) -> Void in
            if let data = pfResults as PFObject!
            {
                data["results"] = rawData
                data.saveInBackground(block: nil)
                
            }else{
                let data = PFObject(className: "rawResults")
                data["task"] = key
                data["student"] = student
                data["results"] = rawData
                data.saveInBackground(block: nil)
            }
        } 
    }
    
    func loadTasks(_ completionBlock: @escaping (_ success: Bool, _ error: String) -> Void){
        let query = PFQuery(className: "rawResults")
        query.whereKey("student", equalTo: self.entity)
        
        query.findObjectsInBackground { (objects, err) -> Void in
            
            if(err != nil){
                completionBlock(false, "\(err)")
                return
            }
            
            for pfobj in objects! as! [PFObject]{
                if let task = pfobj["task"] as? String{
                    if(!self.results.contains(task)){
                        self.results.insert(task)
                    }
                }
            }
            
            completionBlock(true, "")
        }
    }
    
    func save(_ completionBlock: @escaping (_ success: Bool, _ error: String) -> Void){
        let dupeCheck = PFQuery(className: "student")
        dupeCheck.whereKey("classId", equalTo:classId)
        dupeCheck.whereKey("identifier", equalTo:identifier)
        
        dupeCheck.findObjectsInBackground { (objs, err) -> Void in
            
            if(err != nil){
                completionBlock(false, "\(err)")
                
                return
            }
            
            if(objs?.count > 0){
                completionBlock(false, "There is already a student with the identifier \(self.identifier) in this class")
                
                return
            }
            
            let save = self.entity
            save["isCompleted"] = self.isCompleted
            
            save.saveInBackground(block: { (success, err) -> Void in
                if(!success || err != nil){
                    completionBlock(false, "\(err)")
                    
                    return
                }
                
                completionBlock(true, "")
            })
        }
    }
    
    class func LoadStudentsInClass(_ classId: String, completionBlock: @escaping (_ success: Bool, _ error: String, _ students: [StudentDataLayer]?) -> Void){
        let query = PFQuery(className: "student")
        query.whereKey("classId", equalTo: classId)
        query.order(byAscending: "identifier")
        
        query.findObjectsInBackground { (objects, err) -> Void in
            
            var results = [StudentDataLayer]()
            
            if(err != nil){
                completionBlock(false,  "\(err)", results)
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
            
            completionBlock(true, "", results)
        }
    }
}
