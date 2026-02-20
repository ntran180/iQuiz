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

    var topic: QuizTopic!
    var currentQuestionIndex: Int = 0
    var score: Int = 0
    var selectedAnswerIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        displayQuestion()
    }

    func displayQuestion() {
        let question = topic.questions[currentQuestionIndex]
        questionLabel.text = question.text

        let answers = question.answers
        answerButton1.setTitle(answers[0], for: .normal)
        answerButton2.setTitle(answers[1], for: .normal)
        answerButton3.setTitle(answers[2], for: .normal)
        answerButton4.setTitle(answers[3], for: .normal)
    }

    @IBAction func answerTapped(_ sender: UIButton) {
        selectedAnswerIndex = sender.tag
    }

    @IBAction func submitTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showAnswer", sender: self)
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
