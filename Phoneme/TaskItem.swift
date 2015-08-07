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
    let optionsCascade: [Double]
    let correctImage: String
    var demo: Bool = false
    var outro: String?
    var requireResponse: Bool = true
    
    convenience init(audio:String, images:[String], cascade: [Double], correctImage: String){
        self.init(audio:audio, images: images, cascade: cascade, correctImage: correctImage, requireResponse: true)
    }

    convenience init(audio:String, outro: String, images:[String], cascade: [Double], correctImage: String, requireResponse: Bool){
        self.init(audio:audio, images: images, cascade: cascade, correctImage: correctImage, requireResponse: requireResponse)
        self.outro = outro
    }
    
    init(audio:String, images:[String], cascade: [Double], correctImage: String, requireResponse: Bool){
        self.audio = audio
        self.images = images
        self.optionsCascade = cascade
        self.correctImage = correctImage
        self.requireResponse = requireResponse
    }
}

class Task: NSObject{
    let intro: String
    let taskTitle: String
    let items: [TaskItem]
    var outro : String?
    
    init(intro:String, title:String, items:[TaskItem]){
        self.intro = intro
        self.taskTitle = title
        self.items = items;
    }
    
    convenience init(intro:String, outro: String, title:String, items:[TaskItem]){
        self.init(intro: intro, title: title, items: items)
        self.outro = outro
    }
    
    static var emptyTask: Task = Task(intro:"", title:"empty", items:[TaskItem]())
}