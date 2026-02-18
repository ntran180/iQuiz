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
              iconName: "plus.slash.minus"
          ),
          QuizTopic(
              title: "Marvel Super Heroes",
              description: "How well do you know Marvel characters?",
              iconName: "bolt.fill"
          ),
          QuizTopic(
              title: "Science",
              description: "Explore physics, chemistry, and biology.",
              iconName: "atom"
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
    }
