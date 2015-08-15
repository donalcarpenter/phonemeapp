//
//  TaskFactory.swift
//  Phoneme
//
//  Created by donal on 30/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class TaskFactory: NSObject {
    
    static let count: Int = 7
    
    static let familiarisation = Task(intro:"FamIntro", outro:"FamiliarisationEnding", title:"Familiarisation", items:
        [TaskItem(audio:"Fam1", images:["", "green-box", ""], cascade: [0,0,0], correctImage:"green-box"),
            TaskItem(audio:"Fam3", images:["mouse", "seal", "dog"], cascade: [3,4,5], correctImage:"dog"),
            TaskItem(audio:"Fam4", images:["cat", "bear", "spider"], cascade: [2,3,5], correctImage:"cat"),
            TaskItem(audio:"Fam5", images:["fly", "bee", "snake"], cascade: [2,3,5], correctImage:"bee"),
            TaskItem(audio:"Fam6", images:["cow", "pig", "fish"], cascade: [2, 3, 4], correctImage:"fish")])
    
    static let rhymeOddittyTask = Task(intro: "RhymeIntro", outro: "RhymeEnding", title: "Rhyme Odditty", items:
            [TaskItem(audio: "RhymeCatHat", images:["cat", "hat"], cascade: [0,0,0, 0], correctImage:"cat", requireResponse:false),
            TaskItem(audio: "RhymeBoatGoat", images:["boat", "goat"], cascade: [0,0], correctImage:"cat", requireResponse:false),
                TaskItem(audio:"RhymeFishDish", outro:"RhymeBall", images: ["fish", "dish", "ball"], cascade: [6, 8, 10], correctImage:"ball", requireResponse:false),
                TaskItem(audio:"RhymeHatBat", outro:"RhymePig", images:["pig", "hat", "bat"], cascade: [3, 5, 6], correctImage: "pig", requireResponse:false),
            TaskItem(audio:"Rhyme4", images:["cat", "mat", "bus"], cascade: [4, 5, 6], correctImage: "bus"),
            TaskItem(audio:"Rhyme5", images:["peg", "doll", "leg"], cascade: [4, 5, 6], correctImage: "doll"),
            TaskItem(audio:"Rhyme6", images:["saw", "toe", "bow"], cascade: [3, 5, 6], correctImage: "saw"),
            TaskItem(audio:"Rhyme7", images:["sand", "hand", "cup"], cascade: [3, 4, 6], correctImage: "cup"),
            TaskItem(audio:"Rhyme8", images:["hen", "car", "pen"], cascade: [4, 5, 6], correctImage: "car"),
            TaskItem(audio:"Rhyme9", images:["dog", "book", "hook"], cascade: [3, 4, 6], correctImage: "dog"),
            TaskItem(audio:"Rhyme10", images:["bun", "sun", "kite"], cascade: [3, 4, 6], correctImage: "kite"),
            TaskItem(audio:"Rhyme11", images:["tent", "lock", "sock"], cascade: [3, 5, 6], correctImage: "tent"),
            TaskItem(audio:"Rhyme12", images:["shell", "duck", "bell"], cascade: [3, 5, 6], correctImage: "duck"),
            TaskItem(audio:"Rhyme13", images:["ring", "sing", "lamb"], cascade: [4, 5, 6], correctImage: "lamb")
            ])
    
    static let initialPhonemeTask = Task(intro:"InitialPhonemeIntro", outro:"InitPhonEnding", title: "Initial Phoneme Identity Task", items:
        [   InitialPhonemeTaskItem(firstImage: "dog", delay:18, audio: "InitialPhoneme1", images: ["moon", "duck", "whale"], cascade: [2, 3, 5], correctImage: "duck", requireResponse: true, outro:"InitialPhoneme2"),
            InitialPhonemeTaskItem(firstImage: "dog", delay:4, audio: "InitialPhoneme3", images: ["horse", "rope", "door"], cascade: [1, 2, 3], correctImage: "door", requireResponse: true, outro:"InitialPhoneme4"),
            InitialPhonemeTaskItem(firstImage: "mouse", delay:13,  audio: "InitialPhoneme5", images: ["doll", "bear", "milk"], cascade: [1, 2, 3], correctImage: "milk"),
            InitialPhonemeTaskItem(firstImage: "mouse", delay:5, audio: "InitialPhoneme6", images: ["mat", "dog", "book"], cascade: [0.4, 2, 3], correctImage: "mat"),
            InitialPhonemeTaskItem(firstImage: "seal", delay:11,  audio: "InitialPhoneme7", images: ["bee", "sun", "tent"], cascade: [3, 4, 6], correctImage: "sun"),
            InitialPhonemeTaskItem(firstImage: "seal", delay:5, audio: "InitialPhoneme8", images: ["saw", "tie", "hook"], cascade: [1, 2, 4], correctImage: "saw"),
            InitialPhonemeTaskItem(firstImage: "cat", delay:11,  audio: "InitialPhoneme9", images: ["bus", "kite", "arm"], cascade: [2, 4, 5], correctImage: "kite"),
            InitialPhonemeTaskItem(firstImage: "cat", delay:5,  audio: "InitialPhoneme10", images: ["comb", "dish", "soap"], cascade: [4, 5, 7], correctImage: "comb"),
            InitialPhonemeTaskItem(firstImage: "bee", delay:12, audio: "InitialPhoneme11", images: ["cat", "leg", "ball"], cascade: [2, 3, 4], correctImage: "ball"),
            InitialPhonemeTaskItem(firstImage: "bee", delay:5,  audio: "InitialPhoneme12", images: ["car", "boat", "shoe"], cascade: [1, 2, 3], correctImage: "boat"),
            InitialPhonemeTaskItem(firstImage: "fish", delay:13,  audio: "InitialPhoneme13", images: ["foot", "hat", "pig"], cascade: [1, 3, 4], correctImage: "foot"),
            InitialPhonemeTaskItem(firstImage: "fish", delay:5,  audio: "InitialPhoneme14", images: ["duck", "bell", "fire"], cascade: [1, 2, 3], correctImage: "fire")
        ])

    static let finalPhonemeTask = Task(intro: "FinalPhonemeIntro", outro:"FinalPhonEnding", title: "Final Phoneme Indentity Task", items:
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
    
    static let letterNameTask = Task(intro: "LNRecIntro", outro:"LNRec25", title:"Letter Name Recognition Task", blocking: true, items:
        [
            TaskItem(audio: "LNRec1", outro:"LNRec2", images:["j", "r", "", ""], cascade: [], correctImage:"j", requireResponse:true),
            TaskItem(audio: "LNRec3", outro:"LNRec4", images:["j", "r", "", ""], cascade: [], correctImage:"r", requireResponse:true),
            
            TaskItem(audio: "LNRec5", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "m"),
            TaskItem(audio: "LNRec6", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "s"),
            TaskItem(audio: "LNRec7", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "k"),
            TaskItem(audio: "LNRec8", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "b"),
            TaskItem(audio: "LNRec9", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "n"),
            TaskItem(audio: "LNRec10", outro:"LNRec11", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "f", requireResponse:true),
            
            TaskItem(audio: "LNRec12", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "d"),
            TaskItem(audio: "LNRec13", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "h"),
            TaskItem(audio: "LNRec14", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "p"),
            TaskItem(audio: "LNRec15", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "t"),
            TaskItem(audio: "LNRec16", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "w"),
            TaskItem(audio: "LNRec17", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "g"),

            TaskItem(audio: "LNRec18", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "c"),
            TaskItem(audio: "LNRec20", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "z"),
            TaskItem(audio: "LNRec21", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "l"),
            TaskItem(audio: "LNRec22", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "q"),
            TaskItem(audio: "LNRec23", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "v"),
            TaskItem(audio: "LNRec24", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "y"),
    ])
    
    static let letterSoundTask = Task(intro: "LSRecIntro", outro:"LSRec23", title:"Letter Name Recognition Task", blocking:true, items:
        [
            TaskItem(audio: "LSRec1", outro:"LSRec2", images:["j", "r", "", ""], cascade: [], correctImage:"r", requireResponse:true),
            TaskItem(audio: "LSRec3", outro:"LSRec4", images:["j", "r", "", ""], cascade: [], correctImage:"j", requireResponse:true),
            
            TaskItem(audio: "LSRec5", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "m"),
            TaskItem(audio: "LSRec6", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "s"),
            TaskItem(audio: "LSRec7", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "k"),
            TaskItem(audio: "LSRec8", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "b"),
            TaskItem(audio: "LSRec9", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "n"),
            TaskItem(audio: "LSRec10", images: ["b", "s", "n", "m", "f", "k"], cascade: [0,0,0,0,0,0], correctImage: "f"),
            
            TaskItem(audio: "LSRec11", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "d"),
            TaskItem(audio: "LSRec12", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "h"),
            TaskItem(audio: "LSRec13", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "p"),
            TaskItem(audio: "LSRec14", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "t"),
            TaskItem(audio: "LSRec15", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "w"),
            TaskItem(audio: "LSRec16", images: ["d", "w", "h", "t", "g", "p"], cascade: [0,0,0,0,0,0], correctImage: "g"),
            
            TaskItem(audio: "LSRec17", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "c"),
            TaskItem(audio: "LSRec18", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "z"),
            TaskItem(audio: "LSRec19", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "l"),
            TaskItem(audio: "LSRec20", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "q"),
            TaskItem(audio: "LSRec21", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "v"),
            TaskItem(audio: "LSRec22", images: ["q", "v", "z", "l", "c", "y"], cascade: [0,0,0,0,0,0], correctImage: "y"),
        ])
    
    static let singleWordTask = Task(intro:"WordReadIntro", outro: "WordRead15", title:"Single Word Reading Task", blocking:false, items:[
            InitialPhonemeTaskItem(firstImage: "sheep", delay:0, audio: "WordRead1", images: ["sheep", "shark", "elephant"], cascade: [], correctImage: "sheep", requireResponse: false, outro:"WordRead2"),
            InitialPhonemeTaskItem(firstImage: "frog", delay:0, audio: "WordRead3", images: ["pig", "frog", "fish"], cascade: [], correctImage: "frog", requireResponse: false, outro:"WordRead4"),
            InitialPhonemeTaskItem(firstImage: "dog", delay: 3, audio: "WordRead5", images: ["dog", "dot", "man"], cascade: [], correctImage: "dog"),
            InitialPhonemeTaskItem(firstImage: "mouse", delay: 4, audio: "WordRead6", images: ["ring", "mouse", "mouth"], cascade: [], correctImage: "mouse"),
            InitialPhonemeTaskItem(firstImage: "seal", delay: 4, audio: "WordRead7", images: ["seat", "duck", "seal"], cascade: [], correctImage: "seal"),
            InitialPhonemeTaskItem(firstImage: "cat", delay: 3, audio: "WordRead8", images: ["cat", "cake", "hen"], cascade: [], correctImage: "cat"),
            InitialPhonemeTaskItem(firstImage: "bee", delay: 4, audio: "WordRead9", images: ["sun", "bee", "bear"], cascade: [], correctImage: "bee"),
            InitialPhonemeTaskItem(firstImage: "fish", delay: 3, audio: "WordRead10", images: ["fire", "lock", "fish"], cascade: [], correctImage: "fish"),
            InitialPhonemeTaskItem(firstImage: "snake", delay: 4, audio: "WordRead11", images: ["snake", "snail", "deer"], cascade: [], correctImage: "snake"),
            InitialPhonemeTaskItem(firstImage: "shark", delay: 3, audio: "WordRead12", images: ["cow", "shark", "sheep"], cascade: [], correctImage: "shark"),
            InitialPhonemeTaskItem(firstImage: "horse", delay: 3, audio: "WordRead13", images: ["house", "bug", "horse"], cascade: [], correctImage: "horse"),
            InitialPhonemeTaskItem(firstImage: "spider", delay: 3, audio: "WordRead14", images: ["spider", "space", "pig"], cascade: [], correctImage: "spider"),
        ])
}
