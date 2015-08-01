//
//  ClassDataLayer.swift
//  Phoneme
//
//  Created by donal on 01/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import Parse

class ClassDataLayer: NSObject {
    let objectId: String
    let schoolId: String
    let className: String
    let teacherName: String
 
    init(objectId: String, schoolId: String, className: String, teacherName: String){
        self.objectId = objectId
        self.schoolId = schoolId
        self.className = className
        self.teacherName = teacherName
    }
    
    class func new(schoolId: String, className: String, teacherName: String) -> ClassDataLayer{
        return ClassDataLayer(objectId: "", schoolId: schoolId, className: className, teacherName: teacherName)
    }
    
    func save(completionBlock: (success: Bool, error: String) -> Void){
        let dupeCheck = PFQuery(className: "class")
        dupeCheck.whereKey("schoolId", equalTo: schoolId)
        dupeCheck.whereKey("name", equalTo: className)
        
        dupeCheck.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if(objects?.count > 0){
                completionBlock(success: false, error: "\(self.className) already exists in this school")
                return
            }
            
            let save = PFObject(className: "class")
            save["schoolId"] = self.schoolId
            save["name"] = self.className
            save["teacherName"] = self.teacherName
            
            save.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                completionBlock(success: success, error: "\(error)")
            })
            
        }
    }
    
    class func loadClassesForSchool(schoolId: String, completionBlock : (success: Bool, error:String, classes: [ClassDataLayer]) -> Void){
        let query = PFQuery(className: "class")
        query.whereKey("schoolId", equalTo: schoolId)
        query.orderByAscending("name")
        
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, err: NSError?) -> Void in
            
            var result = [ClassDataLayer]()
            
            if(err != nil){
                completionBlock(success: false, error: "\(err)", classes: result)
                return
            }
            
            for pfobj in objects! as! [PFObject]{
                result.append(ClassDataLayer(objectId: pfobj.objectId!, schoolId: pfobj["schoolId"] as! String, className: pfobj["name"] as! String, teacherName: pfobj["teacherName"] as! String))
            }
            
            completionBlock(success: true, error: "", classes: result)
        }
    }
}
    