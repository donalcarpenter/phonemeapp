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
    
    init(firstImage: String, audio:String, images:[String], correctImage: String, requireResponse: Bool, outro: String){
        self.firstImage = firstImage
        super.init(audio: audio, images: images, correctImage: correctImage, requireResponse: requireResponse)
    }
    
    convenience init(firstImage: String, audio:String, images:[String], correctImage: String){
        self.init(firstImage:firstImage, audio: audio, images: images, correctImage: correctImage, requireResponse: true, outro:"")
    }
    
    convenience init(firstImage: String, audio:String, images:[String], correctImage: String, outro: String){
        self.init(firstImage:firstImage, audio: audio, images: images, correctImage: correctImage, requireResponse: true, outro:outro)
    }
}