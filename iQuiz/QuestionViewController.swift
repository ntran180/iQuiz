//
//  QuizViewController.swift
//  iQuiz
//
//  Created by Nam Tran on 2/19/26.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var submitButton: UIButton!

    var topic: Quiz?
    var currentQuestionIndex: Int = 0
    var score: Int = 0
    var selectedAnswerIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        displayQuestion()
    }

    func displayQuestion() {
        guard let topic = topic,
              currentQuestionIndex < topic.questions.count else { return }

        selectedAnswerIndex = nil
        submitButton.isEnabled = false

        let question = topic.questions[currentQuestionIndex]
        questionLabel.text = question.text

        let answers = question.answers
        answerButton1.setTitle(answers[0], for: .normal)
        answerButton2.setTitle(answers[1], for: .normal)
        answerButton3.setTitle(answers[2], for: .normal)
        answerButton4.setTitle(answers[3], for: .normal)
    }

    @IBAction func answerTapped(_ sender: UIButton) {
        switch sender {
        case answerButton1: selectedAnswerIndex = 0
        case answerButton2: selectedAnswerIndex = 1
        case answerButton3: selectedAnswerIndex = 2
        case answerButton4: selectedAnswerIndex = 3
        default: break
        }

        submitButton.isEnabled = true
    }

    @IBAction func submitTapped(_ sender: UIButton) {
        guard selectedAnswerIndex != nil else { return }
        performSegue(withIdentifier: "showAnswer", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAnswer" {
            let destination = segue.destination as! AnswersViewController
            destination.topic = topic
            destination.currentQuestionIndex = currentQuestionIndex
            destination.score = score
            destination.selectedAnswerIndex = selectedAnswerIndex
        }
    }
}
