//
//  QuizTableViewController.swift
//  iQuiz
//
//  Created by Nam Tran on 2/17/26.
//

import UIKit
import Foundation

class QuizTableViewController: UITableViewController {
    var quizzes: [QuizTopic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iQuiz"
        setupToolbar()
        loadQuizzes()
    }
    
    private func loadQuizzes() {
        QuizService.shared.fetchQuizzes { result in
            DispatchQueue.main.async {
                switch result {

                case .success(let topics):
                    self.quizzes = topics
                    self.tableView.reloadData()

                case .failure:
                    let alert = UIAlertController(
                        title: "Network Error",
                        message: "Unable to load quizzes. Please check your internet connection.",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
        navigationController?.pushViewController(settingsVC, animated: true)
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
            cell.detailTextLabel?.text = quiz.desc
            cell.imageView?.image = UIImage(systemName: quiz.iconName)

            cell.accessoryType = .disclosureIndicator
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
