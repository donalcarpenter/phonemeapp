//
//  SchoolsDataLayer.swift
//  Phoneme
//
//  Created by donal on 01/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

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


class SchoolsDataLayer: NSObject {
    
    let schoolName: String
    let objectId: String
    
    init (schoolName: String, objectId: String){
        self.schoolName = schoolName
        self.objectId = objectId
    }
    
    class func loadSchools(_ completionBlock: @escaping (_ success: Bool, _ error: String, _ schools:[SchoolsDataLayer]?) -> Void){
        let query = PFQuery(className: "school")
        query.order(byAscending: "name")
    
        
        query.findObjectsInBackground { (schools, error) -> Void in
            if(error != nil){
                completionBlock( false, "\(error)", nil)
            }
            
            var result = [SchoolsDataLayer]()
            
            for pfobj in schools! as! [PFObject]{
                result.append(SchoolsDataLayer(schoolName: pfobj["name"] as! String, objectId: pfobj.objectId!))
            }
            
            completionBlock(true,  "", result)
        }
    }
    
    class func saveNewSchool(_ schoolName: String, completionBlock: @escaping (_ success: Bool, _ error: String) -> Void){
        
        let checkDupes = PFQuery(className: "school")
        checkDupes.whereKey("name", equalTo: schoolName)

        checkDupes.findObjectsInBackground { (schools, error) -> Void in
            if(schools?.count > 0){
                
                completionBlock(false, "the school \(schoolName) already exists")
                
                return
            }
            
            let newSchool = PFObject(className: "school")
            newSchool["name"] = schoolName
            
            newSchool.saveInBackground(block: { (success, err) -> Void in
                completionBlock(success, "\(err)")
            })
        }
    }
}
