//
//  TaskFactory.swift
//  Phoneme
//
//  Created by donal on 30/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class TaskFactory: NSObject {
    
    static let count: Int = 4
    
    static let familiarisation = Task(intro:"FamIntro", title:"Familiarisation", items:
        [TaskItem(audio:"Fam1", images:["", "green-box", ""], cascade: [0,0,0], correctImage:"green-box"),
            TaskItem(audio:"Fam3", images:["mouse", "seal", "dog"], cascade: [3,4,5], correctImage:"dog"),
            TaskItem(audio:"Fam4", images:["cat", "bear", "spider"], cascade: [2,3,5], correctImage:"cat"),
            TaskItem(audio:"Fam5", images:["fly", "bee", "snake"], cascade: [2,3,5], correctImage:"bee"),
            TaskItem(audio:"Fam6", images:["cow", "pig", "fish"], cascade: [2, 3, 4], correctImage:"fish")])
    
    static let rhymeOddittyTask = Task(intro: "RhymeIntro", title: "Rhyme Odditty", items:
            [TaskItem(audio: "Rhyme1", images:["cat", "hat", "boat", "goat"], cascade: [0,0,0], correctImage:"cat", requireResponse:false),
            TaskItem(audio:"Rhyme2", images: ["fish", "dish", "ball"], cascade: [6, 8, 10], correctImage:"ball", requireResponse:false),
            TaskItem(audio:"Rhyme3", images:["pig", "hat", "bat"], cascade: [3, 5, 6], correctImage: "pig", requireResponse:false),
            TaskItem(audio:"Rhyme4", images:["cat", "mat", "bus"], cascade: [4, 5, 6], correctImage: "bus"),
            TaskItem(audio:"Rhyme5", images:["peg", "doll", "leg"], cascade: [4, 5, 6], correctImage: "doll"),
            TaskItem(audio:"Rhyme6", images:["saw", "toe", "bow"], cascade: [3, 5, 6], correctImage: "saw"),
            TaskItem(audio:"Rhyme7", images:["sand", "hand", "cup"], cascade: [3, 4, 6], correctImage: "cup"),
            TaskItem(audio:"Rhyme8", images:["hen", "car", "pen"], cascade: [4, 5, 6], correctImage: "car"),
            TaskItem(audio:"Rhyme9", images:["dog", "book", "hook"], cascade: [3, 4, 6], correctImage: "dog"),
            TaskItem(audio:"Rhyme10", images:["bun", "sun", "kite"], cascade: [4, 5, 6], correctImage: "kite"),
            TaskItem(audio:"Rhyme11", images:["tent", "lock", "sock"], cascade: [3, 5, 6], correctImage: "tent"),
            TaskItem(audio:"Rhyme12", images:["shell", "duck", "bell"], cascade: [3, 5, 6], correctImage: "duck"),
            TaskItem(audio:"Rhyme13", images:["ring", "sing", "lamb"], cascade: [4, 5, 6], correctImage: "lamb")
            ])
    
    static let initialPhonemeTask = Task(intro:"InitialPhonemeIntro", title: "Initial Phoneme Identity Task", items:
        [   InitialPhonemeTaskItem(firstImage: "dog", delay:18, audio: "InitialPhoneme1", images: ["moon", "duck", "whale"], cascade: [20, 21, 23], correctImage: "duck", requireResponse: true, outro:"InitialPhoneme2"),
            InitialPhonemeTaskItem(firstImage: "dog", delay:4, audio: "InitialPhoneme3", images: ["horse", "rope", "door"], cascade: [5, 6, 7], correctImage: "door", requireResponse: true, outro:"InitialPhoneme4"),
            InitialPhonemeTaskItem(firstImage: "mouse", delay:13,  audio: "InitialPhoneme5", images: ["doll", "bear", "milk"], cascade: [14, 15, 16], correctImage: "milk"),
            InitialPhonemeTaskItem(firstImage: "mouse", delay:5, audio: "InitialPhoneme6", images: ["mat", "dog", "book"], cascade: [5, 7, 8], correctImage: "mat"),
            InitialPhonemeTaskItem(firstImage: "seal", delay:11,  audio: "InitialPhoneme7", images: ["bee", "sun", "tent"], cascade: [14, 15, 17], correctImage: "sun"),
            InitialPhonemeTaskItem(firstImage: "seal", delay:5, audio: "InitialPhoneme8", images: ["saw", "tie", "hook"], cascade: [6, 7, 9], correctImage: "saw"),
            InitialPhonemeTaskItem(firstImage: "cat", delay:11,  audio: "InitialPhoneme9", images: ["bus", "kite", "arm"], cascade: [13, 15, 16], correctImage: "kite"),
            InitialPhonemeTaskItem(firstImage: "cat", delay:5,  audio: "InitialPhoneme10", images: ["comb", "dish", "soap"], cascade: [5, 7, 9], correctImage: "comb"),
            InitialPhonemeTaskItem(firstImage: "bee", delay:12, audio: "InitialPhoneme11", images: ["cat", "leg", "ball"], cascade: [14, 15, 16], correctImage: "ball"),
            InitialPhonemeTaskItem(firstImage: "bee", delay:5,  audio: "InitialPhoneme12", images: ["car", "boat", "shoe"], cascade: [6, 7, 8], correctImage: "boat"),
            InitialPhonemeTaskItem(firstImage: "fish", delay:13,  audio: "InitialPhoneme13", images: ["foot", "hat", "pig"], cascade: [14, 16, 17], correctImage: "foot"),
            InitialPhonemeTaskItem(firstImage: "fish", delay:5,  audio: "InitialPhoneme14", images: ["duck", "bell", "fire"], cascade: [6, 7, 8], correctImage: "fire")
        ])

    static let finalPhonemeTask = Task(intro: "FinalPhonemeIntro", title: "Final Phoneme Indentity Task", items:
    [
        TaskItem(audio: "FinalPhoneme1", outro:"FinalPhoneme2", images:["cat", "can", "man"], cascade: [8, 10, 12], correctImage:"cat", requireResponse:false),
             TaskItem(audio: "FinalPhoneme3", outro:"FinalPhoneme4", images:["shoe", "kite", "ship"], cascade: [3, 4, 6], correctImage:"ship", requireResponse:false),
             TaskItem(audio: "FinalPhoneme5", images:["room", "seal", "soup"], cascade: [2, 3, 5], correctImage:"room"),
             TaskItem(audio: "FinalPhoneme6", images:["hat", "hole", "sun"], cascade: [2, 4, 5], correctImage:"hat"),
             TaskItem(audio: "FinalPhoneme7", images:["rope", "rice", "pan"], cascade: [2, 3, 5], correctImage:"rice"),
             TaskItem(audio: "FinalPhoneme8", images:["food", "fan", "hook"], cascade: [3, 4, 6], correctImage:"food"),
             TaskItem(audio: "FinalPhoneme9", images:["green", "grass", "fire"], cascade: [3, 4, 6], correctImage:"grass"),
             TaskItem(audio: "FinalPhoneme10", images:["hand", "horse", "milk"], cascade: [2, 4, 6], correctImage:"hand"),
             TaskItem(audio: "FinalPhoneme11", images:["ball", "goat", "bank"], cascade: [2, 4, 6], correctImage:"bank"),
             TaskItem(audio: "FinalPhoneme12", images:["cake", "camp", "bed"], cascade: [2, 4, 5], correctImage:"camp"),
             TaskItem(audio: "FinalPhoneme13", images:["world", "walk", "face"], cascade: [2, 4, 6], correctImage:"world"),
             TaskItem(audio: "FinalPhoneme14", images:["tent", "toast", "map"], cascade: [2, 4, 6], correctImage:"map")
        ])
}
