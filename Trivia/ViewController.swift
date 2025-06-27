//
//  ViewController.swift
//  Trivia
//
//  Created by Lei Lei on 6/26/25.
//

import UIKit

struct Question {
    let category: String
    let text: String
    let answers: [String]
    let correctAnswer: String
}


class ViewController: UIViewController {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        [answerButton1, answerButton2, answerButton3, answerButton4].forEach {
            $0?.titleLabel?.numberOfLines = 0
            $0?.titleLabel?.lineBreakMode = .byWordWrapping
            $0?.setTitleColor(.white, for: .normal)
        }
        restartButton.isHidden = true
        displayQuestion()
        
    }
    let questions: [Question] = [
        Question(category: "Entertainment: Video Games",
                 text: "What was the first weapon pack for 'PAYDAY'?",
                 answers: ["The Gage Weapon Pack #1", "The Overkill Pack", "The Gage Chivalry Pack", "The Gage Historical Pack"],
                 correctAnswer: "The Gage Weapon Pack #1"),
        Question(category: "History",
                 text: "Which of these founding fathers of the United States of America later became president?",
                 answers: ["Roger Sherman", "James Monroe", "Samuel Adams", "Alexander Hamilton"],
                 correctAnswer: "James Monroe"),
        Question(category: "Geography",
                 text: "What is the capital of Australia?",
                 answers: ["Sydney", "Melbourne", "Canberra", "Perth"],
                 correctAnswer: "Canberra")
    ]

    var currentQuestionIndex = 0
    var score = 0


    func displayQuestion() {
        let current = questions[currentQuestionIndex]
        questionLabel.text = current.text
        categoryLabel.text = current.category
        progressLabel.text = "Question: \(currentQuestionIndex + 1)/\(questions.count)"
        let answers = current.answers.shuffled()
        answerButton1.setTitle(answers[0], for: .normal)
        answerButton2.setTitle(answers[1], for: .normal)
        answerButton3.setTitle(answers[2], for: .normal)
        answerButton4.setTitle(answers[3], for: .normal)

        // Reset button background colors (optional)
        [answerButton1, answerButton2, answerButton3, answerButton4].forEach {
            $0?.backgroundColor = UIColor.systemBlue
        }
    }

    @IBAction func answerTapped(_ sender: UIButton) {
        guard currentQuestionIndex < questions.count else { return }

        let selected = sender.currentTitle
        let correct = questions[currentQuestionIndex].correctAnswer

        if selected == correct {
            score += 1
            sender.backgroundColor = UIColor.systemGreen
        } else {
            sender.backgroundColor = UIColor.systemRed
        }

        // Delay next question to show feedback
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.moveToNextQuestion()
        }
    }

    func moveToNextQuestion() {
        currentQuestionIndex += 1

        if currentQuestionIndex < questions.count {
            displayQuestion()
        } else {
            showFinalScore()
        }
    }

    func showFinalScore() {
        questionLabel.text = "You got \(score) out of \(questions.count) correct!"
        categoryLabel.text = ""
        progressLabel.text = "Quiz Complete"

        [answerButton1, answerButton2, answerButton3, answerButton4].forEach {
            $0?.isHidden = true
        }

        restartButton.isHidden = false
    }

    @IBAction func restartQuiz(_ sender: UIButton) {
        currentQuestionIndex = 0
        score = 0
        [answerButton1, answerButton2, answerButton3, answerButton4].forEach {
            $0?.isHidden = false
        }
        restartButton.isHidden = true
        displayQuestion()
    }
    


}
