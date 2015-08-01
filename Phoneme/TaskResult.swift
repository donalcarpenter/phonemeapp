//
//  TaskResult.swift
//  Phoneme
//
//  Created by donal on 01/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit

class TaskResult: NSObject {
    let studentId : String
    let taskTitle : String
    let numberOfQuestions : Int
    let correctAnswers : Int
    var rawData : [TaskResultRawItem]?
    
    init (studentId: String, title: String, count: Int, correct: Int){
        self.studentId = studentId
        self.taskTitle = title
        self.numberOfQuestions = count
        self.correctAnswers = correct
    }
}

class TaskResultRawItem : NSObject {
    let index : Int
    let correctAnswer : String
    let givenAnswer : String
    
    init (index: Int, correctAnswer: String, givenAnswer: String){
        self.index = index
        self.correctAnswer = correctAnswer
        self.givenAnswer = givenAnswer
    }
}
