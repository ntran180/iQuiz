//
//  AnswersViewController.swift
//  iQuiz
//
//  Created by Nam Tran on 2/19/26.
//
import UIKit


class AnswersViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    //properties
    var topic: QuizTopic!
    var currentQuestionIndex: Int!
    var score: Int!
    var selectedAnswerIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAnswer()
    }
    
    func displayAnswer(){
        let question = topic.questions[currentQuestionIndex]
        
        questionLabel.text = question.text
        correctAnswerLabel.text = "Correct Answer: \(question.answers[question.correctAnswerIndex])"

        if selectedAnswerIndex == question.correctAnswerIndex {
            resultLabel.text = "Correct!"
            score += 1
        } else {
            resultLabel.text = "Wrong!"
        }
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if currentQuestionIndex + 1 < topic.questions.count {
            performSegue(withIdentifier: "nextQuestion", sender: self)
        } else {
            performSegue(withIdentifier: "showFinished", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAnswer",
           let destination = segue.destination as? AnswersViewController {
            destination.topic = topic
            destination.currentQuestionIndex = currentQuestionIndex
            destination.score = score
            destination.selectedAnswerIndex = selectedAnswerIndex
        }
    }
    
}
