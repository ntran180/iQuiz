//
//  QuizTableViewController.swift
//  iQuiz
//
//  Created by Nam Tran on 2/17/26.
//

import UIKit

class QuizTableViewController: UITableViewController {
    let quizzes: [QuizTopic] = [
          QuizTopic(
              title: "Mathematics",
              description: "Test your math skills with fun problems.",
              iconName: "plus.slash.minus",
              questions: [Question(text: "2 + 2 = ?", answers: ["3","4","5","6"], correctAnswerIndex: 1)]
          ),
          QuizTopic(
              title: "Marvel Super Heroes",
              description: "How well do you know Marvel characters?",
              iconName: "bolt.fill",
              questions: [Question(text: "Who is Spiderman?", answers: ["Peter Parker","Tony Stark","Thor Odinson","Bruce Banner"], correctAnswerIndex: 0)]
          ),
          QuizTopic(
              title: "Science",
              description: "Explore physics, chemistry, and biology.",
              iconName: "atom",
              questions: [Question(text: "What is the common name for the compound H20?", answers: ["Oxygen","Water","Ozone","Salt"], correctAnswerIndex: 1)]
          )
      ]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iQuiz"
        setupToolbar()
    }
    private func setupToolbar() {
        let settingsButton = UIBarButtonItem(
            title: "Settings",
            style: .plain,
            target: self,
            action: #selector(showSettings)
        )

        navigationItem.rightBarButtonItem = settingsButton
    }

    @objc private func showSettings() {
        let alert = UIAlertController(
            title: "Settings",
            message: "Settings go here",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return quizzes.count
        }

        override func tableView(
            _ tableView: UITableView,
            cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell {

            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "QuizCell")

            let quiz = quizzes[indexPath.row]

            cell.textLabel?.text = quiz.title
            cell.detailTextLabel?.text = quiz.description

            cell.imageView?.image = UIImage(systemName: quiz.iconName)

            return cell
        }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showQuestion", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestion",
           let indexPath = sender as? IndexPath,
           let destination = segue.destination as? QuestionViewController {

            destination.topic = quizzes[indexPath.row]
            destination.currentQuestionIndex = 0
            destination.score = 0
        }
    }
}
