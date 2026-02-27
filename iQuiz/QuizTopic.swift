//
//  QuizTopic.swift
//  iQuiz
//
//  Created by Nam Tran on 2/17/26.
//

import UIKit
import Foundation


struct Quiz: Codable {
    let title: String
    let desc: String
    let questions: [Question]
    let icon: String?
}

struct Question: Codable {
    let text: String
    let answers: [String]
    let answer: String
}
