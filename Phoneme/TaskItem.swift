//
//  TaskItem.swift
//  Phoneme
//
//  Created by donal on 24/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class TaskItem: NSObject {
    let audio : String
    let images: [String]
    let correctImage: String
    
    init(audio:String, images:[String], correctImage: String){
        self.audio = audio
        self.images = images
        self.correctImage = correctImage
    }
}

class Task: NSObject{
    let intro: String
    let taskTitle: String
    let items: [TaskItem]
    
    init(intro:String, title:String, items:[TaskItem]){
        self.intro = intro
        self.taskTitle = title
        self.items = items;
        
    }
}