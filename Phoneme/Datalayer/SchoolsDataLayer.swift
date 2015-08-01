//
//  SchoolsDataLayer.swift
//  Phoneme
//
//  Created by donal on 01/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import Parse

class SchoolsDataLayer: NSObject {
    
    let schoolName: String
    let objectId: String
    
    init (schoolName: String, objectId: String){
        self.schoolName = schoolName
        self.objectId = objectId
    }
    
    class func loadSchools(completionBlock: (success: Bool, error: String, schools:[SchoolsDataLayer]?) -> Void){
        let query = PFQuery(className: "school")
        query.orderByAscending("name")
        
        query.findObjectsInBackgroundWithBlock { (schools:[AnyObject]?, error: NSError?) -> Void in
            if(error != nil){
                completionBlock(success: false, error: "\(error)", schools: nil)
            }
            
            var result = [SchoolsDataLayer]()
            
            for pfobj in schools! as! [PFObject]{
                result.append(SchoolsDataLayer(schoolName: pfobj["name"] as! String, objectId: pfobj.objectId!))
            }
            
            completionBlock(success: true, error: "", schools: result)
        }
    }
    
    class func saveNewSchool(schoolName: String, completionBlock: (success: Bool, error: String) -> Void){
        
        let checkDupes = PFQuery(className: "school")
        checkDupes.whereKey("name", equalTo: schoolName)

        checkDupes.findObjectsInBackgroundWithBlock { (schools:[AnyObject]?, error: NSError?) -> Void in
            if(schools?.count > 0){
                
                completionBlock(success:false, error: "the school \(schoolName) already exists")
                
                return
            }
            
            let newSchool = PFObject(className: "school")
            newSchool["name"] = schoolName
            
            newSchool.saveInBackgroundWithBlock({ (success:Bool, err:NSError?) -> Void in
                completionBlock(success:success, error:"\(err)")
            })
        }
    }
}
