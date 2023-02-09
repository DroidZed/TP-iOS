//
//  ViewController.swift
//  hello-app
//
//  Created by Mac-Mini-2021 on 26/1/2023.
//

import UIKit

class ViewController: UIViewController {
    
    var round = 1
    var score = 0
    var goalN = 0
    
   

    @IBOutlet weak var gameSlider: UISlider!
    @IBOutlet weak var goal: UILabel!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UpdateGame()
        ResetSlider()
    }
    
    @IBAction func slideAction(_ sender: Any) {
        print(gameSlider.value)
    }
    
    @IBAction func hitAction(_ sender: Any) {
        
        let diff = abs(Int(floor(gameSlider.value)) - goalN)
        
        switch (diff) {
            // exact value
        case 0:
            score += 100
        case 0..<5:
            score += 50
        case 5..<10:
            score -= 20
        default:
            //
            score += 0
        }
        
        let alertController = UIAlertController(title: "Aler", message: "You've got \(score) points", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
        round += 1
        goalN = GenerateRandomValue()
        UpdateGame()
    }
    
    @IBAction func resetAction(_ sender: Any) {
        ResetGame()
        ResetSlider()
    }
    
    func UpdateGame() {
        
        goal.text = "\(goalN)"
        roundLabel.text = "Round: \(round)"
        scoreLabel.text = "Score: \(score)"
    }
    
    func ResetGame() {
        
        round = 1
        score = 0
        goalN = GenerateRandomValue()
        
        UpdateGame()
    }
    
    func GenerateRandomValue() -> Int {
        return Int.random(in:1...101)
    }
    
    func ResetSlider() {
        gameSlider.value = 50.0
    }
}
