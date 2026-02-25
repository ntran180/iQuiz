//
//  QuizTopic.swift
//  iQuiz
//
//  Created by Nam Tran on 2/17/26.
//

import UIKit
import Foundation

struct Question: Codable {
    let text: String
    let answers: [String]
    let answer: String
}

struct QuizTopic: Codable {
    let title: String
    let desc: String
    let questions: [Question]
}
extension QuizTopic {
    var iconName: String {
        switch title {
        case "Mathematics":
            return "plus.slash.minus"
        case "Marvel Super Heroes":
            return "bolt.fill"
        case "Science":
            return "atom"
        default:
            return "questionmark.circle"
        }
    }
}
