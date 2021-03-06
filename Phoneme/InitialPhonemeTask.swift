//
//  InitialPhonemeTask.swift
//  Phoneme
//
//  Created by donal on 25/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class InitialPhonemeTaskItem : TaskItem{
    let firstImage: String
    var delay: Double = 0
    
    init(firstImage: String, delay: Double, audio:String, images:[String], cascade:[Double], correctImage: String, requireResponse: Bool, outro: String){
        self.firstImage = firstImage
        self.delay = delay
        super.init(audio: audio, images: images, cascade: cascade, correctImage: correctImage, requireResponse: requireResponse)
        
        if(outro != ""){
            self.outro = outro
        }
    }
    
    convenience init(firstImage: String, delay: Double, audio:String, images:[String], cascade:[Double], correctImage: String){
        self.init(firstImage:firstImage, delay: delay, audio: audio, images: images, cascade: cascade, correctImage: correctImage, requireResponse: true, outro:"")
    }
    
    convenience init(firstImage: String, delay: Double, audio:String, images:[String], cascade:[Double], correctImage: String, outro: String){
        self.init(firstImage:firstImage, delay:delay, audio: audio, images: images, cascade: cascade, correctImage: correctImage, requireResponse: true, outro:outro)
    }
}