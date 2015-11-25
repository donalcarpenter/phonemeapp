//
//  SegmentationTaskItem.swift
//  Phoneme
//
//  Created by donal on 25/11/2015.
//  Copyright © 2015 donal. All rights reserved.
//

import UIKit

class SegmentationTaskItem: TaskItem {
    let image: String
    
    convenience init(image: String, audio:String, correctCount: Int, outro: String){
        self.init(image: image, audio: audio, correctCount: correctCount, demo: false, demoDelay: [], outro: outro)
    }

    convenience init(image: String, audio:String, correctCount: Int){
        self.init(image: image, audio: audio, correctCount: correctCount, demo: false, demoDelay: [], outro: "")
    }
    
    convenience init(image: String, audio:String, correctCount: Int, demo: Bool, demoDelay: [Double]){
        self.init(image: image, audio: audio, correctCount: correctCount, demo: false, demoDelay: [], outro: "")
    }
    
    init(image: String, audio:String, correctCount: Int, demo: Bool, demoDelay: [Double], outro: String){
        self.image = image
        super.init(audio: audio, images: ["green-square", "green-square", "green-square", "green-square", "green-square", "star"], cascade: [], correctImage: String(correctCount), requireResponse: !demo)
        
        if(outro != ""){
            self.outro = outro
        }
    }
    
}
