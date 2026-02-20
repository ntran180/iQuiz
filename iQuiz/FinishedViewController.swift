//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Nam Tran on 2/19/26.
//

import UIKit

class FinishedViewController: UIViewController {
    
    @IBOutlet weak var performanceLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int = 0
    var totalQuestions: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayResults()
    }
    
    func displayResults() {
           // Score text
           scoreLabel.text = "\(score) of \(totalQuestions) correct"

           // Performance description
           let percentage = Double(score) / Double(totalQuestions)
           switch percentage {
           case 1.0:
               performanceLabel.text = "Perfect!"
           case 0.7..<1.0:
               performanceLabel.text = "Great Job!"
           case 0.4..<0.7:
               performanceLabel.text = "Almost!"
           default:
               performanceLabel.text = "Keep Practicing!"
           }
       }

    
    @IBAction func nextTapped(_ sender: UIButton) {
        // Return to main quiz topics
        navigationController?.popToRootViewController(animated: true)
    }
}
