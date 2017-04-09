//
//  ClassDataLayer.swift
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
    
    class func new(_ schoolId: String, className: String, teacherName: String) -> ClassDataLayer{
        return ClassDataLayer(objectId: "", schoolId: schoolId, className: className, teacherName: teacherName)
    }
    
    func save(_ completionBlock: @escaping (_ success: Bool, _ error: String) -> Void){
        let dupeCheck = PFQuery(className: "class")
        dupeCheck.whereKey("schoolId", equalTo: schoolId)
        dupeCheck.whereKey("name", equalTo: className)
        
        dupeCheck.findObjectsInBackground { (objects, error) -> Void in
            if(objects?.count > 0){
                completionBlock(false, "\(self.className) already exists in this school")
                return
            }
            
            let save = PFObject(className: "class")
            save["schoolId"] = self.schoolId
            save["name"] = self.className
            save["teacherName"] = self.teacherName
            
            save.saveInBackground(block: { (success, error) -> Void in
                completionBlock(success, "\(error)")
            })
            
        }
    }
    
    class func loadClassesForSchool(_ schoolId: String, completionBlock : @escaping (_ success: Bool, _ error:String, _ classes: [ClassDataLayer]) -> Void){
        let query = PFQuery(className: "class")
        query.whereKey("schoolId", equalTo: schoolId)
        query.order(byAscending: "name")
        
        query.findObjectsInBackground { (objects, err) -> Void in
            
            var result = [ClassDataLayer]()
            
            if(err != nil){
                completionBlock( false, "\(err)", result)
                return
            }
            
            for pfobj in objects! as! [PFObject]{
                result.append(ClassDataLayer(objectId: pfobj.objectId!, schoolId: pfobj["schoolId"] as! String, className: pfobj["name"] as! String, teacherName: pfobj["teacherName"] as! String))
            }
            
            completionBlock( true,  "",  result)
        }
    }
}
    
