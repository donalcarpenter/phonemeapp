//
//  TaskFactory.swift
//  Phoneme
//
//  Created by donal on 30/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class TaskFactory: NSObject {
    static let familiarisation = Task(intro:"FamIntro", title:"Familiarisation", items:
        [TaskItem(audio:"Fam1", images:["", "green-box", ""], correctImage:"green-box"),
            TaskItem(audio:"Fam3", images:["mouse", "seal", "dog"], correctImage:"dog"),
            TaskItem(audio:"Fam4", images:["cat", "bear", "spider"], correctImage:"cat"),
            TaskItem(audio:"Fam5", images:["fly", "bee", "snake"], correctImage:"bee"),
            TaskItem(audio:"Fam6", images:["cow", "pig", "fish"], correctImage:"fish")])
    
    static let rhymeOddittyTask = Task(intro: "RhymeIntro", title: "Rhyme Odditty", items:
            [TaskItem(audio: "Rhyme1", images:["cat", "hat", "boat", "goat"], correctImage:"cat", requireResponse:false),
            TaskItem(audio:"Rhyme2", images: ["fish", "dish", "ball"], correctImage:"ball", requireResponse:false),
            TaskItem(audio:"Rhyme3", images:["pig", "hat", "bat"], correctImage: "pig", requireResponse:false),
            TaskItem(audio:"Rhyme4", images:["cat", "mat", "bus"], correctImage: "bus"),
            TaskItem(audio:"Rhyme5", images:["peg", "doll", "leg"], correctImage: "doll"),
            TaskItem(audio:"Rhyme6", images:["saw", "toe", "bow"], correctImage: "saw"),
            TaskItem(audio:"Rhyme7", images:["sand", "hand", "cup"], correctImage: "cup"),
            TaskItem(audio:"Rhyme8", images:["hen", "car", "pen"], correctImage: "car"),
            TaskItem(audio:"Rhyme9", images:["dog", "book", "hook"], correctImage: "dog"),
            TaskItem(audio:"Rhyme10", images:["bun", "sun", "kite"], correctImage: "kite"),
            TaskItem(audio:"Rhyme11", images:["tent", "lock", "sock"], correctImage: "tent"),
            TaskItem(audio:"Rhyme12", images:["shell", "duck", "bell"], correctImage: "duck"),
            TaskItem(audio:"Rhyme13", images:["ring", "sing", "lamb"], correctImage: "lamb")
            ])
    
    static let initialPhonemeTask = Task(intro:"InitialPhonemeIntro", title: "Initial Phoneme Identity Task", items:
        [   InitialPhonemeTaskItem(firstImage: "dog", audio: "InitialPhoneme1", images: ["moon", "duck", "whale"], correctImage: "duck", requireResponse: true, outro:"InitialPhoneme2"),
            InitialPhonemeTaskItem(firstImage: "dog", audio: "InitialPhoneme3", images: ["horse", "rope", "door"], correctImage: "door", requireResponse: true, outro:"InitialPhoneme4"),
            InitialPhonemeTaskItem(firstImage: "mouse", audio: "InitialPhoneme5", images: ["doll", "bear", "milk"], correctImage: "milk"),
            InitialPhonemeTaskItem(firstImage: "mouse", audio: "InitialPhoneme6", images: ["mat", "dog", "book"], correctImage: "mat"),
            InitialPhonemeTaskItem(firstImage: "seal", audio: "InitialPhoneme7", images: ["bee", "sun", "tent"], correctImage: "sun"),
            InitialPhonemeTaskItem(firstImage: "seal", audio: "InitialPhoneme8", images: ["saw", "tie", "hook"], correctImage: "saw"),
            InitialPhonemeTaskItem(firstImage: "cat", audio: "InitialPhoneme9", images: ["bus", "kite", "arm"], correctImage: "kite"),
            InitialPhonemeTaskItem(firstImage: "cat", audio: "InitialPhoneme10", images: ["comb", "dish", "soap"], correctImage: ""),
            InitialPhonemeTaskItem(firstImage: "bee", audio: "InitialPhoneme11", images: ["cat", "leg", "ball"], correctImage: "ball"),
            InitialPhonemeTaskItem(firstImage: "bee", audio: "InitialPhoneme12", images: ["car", "boat", "shoe"], correctImage: "boat"),
            InitialPhonemeTaskItem(firstImage: "fish", audio: "InitialPhoneme13", images: ["foot", "hat", "pig"], correctImage: "foot"),
            InitialPhonemeTaskItem(firstImage: "fish", audio: "InitialPhoneme14", images: ["duck", "bell", "fire"], correctImage: "fire")
        ])

    static let finalPhonemeTask = Task(intro: "FinalPhonemeIntro", title: "Final Phoneme Indentity Task", items:
    [
        TaskItem(audio: "FinalPhoneme1", outro:"FinalPhoneme2", images:["cat", "can", "man"], correctImage:"cat", requireResponse:false),
             TaskItem(audio: "FinalPhoneme3", outro:"FinalPhoneme4", images:["shoe", "kite", "ship"], correctImage:"ship", requireResponse:false),
             TaskItem(audio: "FinalPhoneme5", images:["room", "seal", "soup"], correctImage:"room"),
             TaskItem(audio: "FinalPhoneme6", images:["hat", "hole", "sun"], correctImage:"hat"),
             TaskItem(audio: "FinalPhoneme7", images:["rope", "rice", "pan"], correctImage:"rice"),
             TaskItem(audio: "FinalPhoneme8", images:["food", "fan", "hook"], correctImage:"food"),
             TaskItem(audio: "FinalPhoneme9", images:["green", "grass", "fire"], correctImage:"grass"),
             TaskItem(audio: "FinalPhoneme10", images:["hand", "horse", "milk"], correctImage:"hand"),
             TaskItem(audio: "FinalPhoneme11", images:["ball", "goat", "bank"], correctImage:"bank"),
             TaskItem(audio: "FinalPhoneme12", images:["cake", "camp", "bed"], correctImage:"camp"),
             TaskItem(audio: "FinalPhoneme13", images:["world", "walk", "face"], correctImage:"world"),
             TaskItem(audio: "FinalPhoneme14", images:["tent", "toast", "map"], correctImage:"map")
        ])
}
