//
//  QuizTopic.swift
//  iQuiz
//
//  Created by Nam Tran on 2/17/26.
//

import UIKit

struct Question {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
}

struct QuizTopic {
    let title: String
    let description: String
    let iconName: String
    let questions: [Question] 
}
