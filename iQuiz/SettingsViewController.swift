//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Nam Tran on 2/24/26.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let savedURL = UserDefaults.standard.string(forKey: "quizURL")
        urlTextField.text = savedURL
    }

    @IBAction func saveTapped(_ sender: UIButton) {
        UserDefaults.standard.set(urlTextField.text, forKey: "quizURL")
        statusLabel.text = "URL Saved"
    }

    @IBAction func checkNowTapped(_ sender: UIButton) {

        QuizService.shared.fetchQuizzes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.statusLabel.text = "Download successful"
                case .failure(let error):
                    self.statusLabel.text = error.localizedDescription
                }
            }
        }
    }
}
