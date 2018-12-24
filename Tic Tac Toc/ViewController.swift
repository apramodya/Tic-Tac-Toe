//
//  ViewController.swift
//  Tic Tac Toc
//
//  Created by Pramodya Abeysinghe on 12/22/18.
//  Copyright © 2018 Pramodya Abeysinghe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isPhonePlayer: Bool = false
    var phonesCells = [Int]()
    var playersCells = [Int]()
    var buttonsArray: [UIButton] = []
    var winner: String = ""
    var numberOfClicks: Int = 0
    var availableCells: [Int] = [1,2,3,4,5,6,7,8,9]
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    
    let winningPossibilities: [[Int]] = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsArray = [b1, b2, b3, b4, b5, b6, b7, b8, b9]
    }
    
    @IBAction func pressButton(_ sender: Any) {
        numberOfClicks += 1
        
        // player's chance
        let selectedButton = sender as! UIButton
        playGame(button: selectedButton)
        
        // check whether player is a winner
        if numberOfClicks >= 3 && winnerOfTheGame() == "player" {
            endGame(message: "You won the game")
        }
        else {
            // phone's chance
            let randomNumber = selectRandomNumber()!
            let computersButton = buttonsArray[randomNumber - 1]
            playGame(button: computersButton)
            
            // check whether phone is a winner
            if winnerOfTheGame() == "phone" {
                endGame(message: "Phone won the game")
            }
        }
        
        if winnerOfTheGame() == "" && numberOfClicks == 4 {
            for i in availableCells {
                buttonsArray[i-1].isEnabled = false
            }
            endGame(message: "Game is drawn")
        }
        
    }
    
    func playGame(button selectedButton: UIButton) {

        if isPhonePlayer {
            selectedButton.setTitle("O", for: UIControl.State.normal)
            selectedButton.backgroundColor = UIColor(red: 102/255, green: 250/255, blue: 51/255, alpha: 0.5)
            phonesCells.append(selectedButton.tag)
            availableCells = availableCells.filter{ $0 != selectedButton.tag }
           
            isPhonePlayer = !isPhonePlayer
        } else {
            selectedButton.setTitle("X", for: UIControl.State.normal)
            selectedButton.backgroundColor = UIColor(red: 32/255, green: 192/255, blue: 243/255, alpha: 0.5)
            playersCells.append(selectedButton.tag)
            availableCells = availableCells.filter{ $0 != selectedButton.tag }
           
            isPhonePlayer = !isPhonePlayer
        }
        
        selectedButton.isEnabled = false
    }
    
    func selectRandomNumber() -> Int? {
        return availableCells.randomElement()
    }
    
    func winnerOfTheGame() -> String {
        for possibility in winningPossibilities {
            // check whether player is the winner
            let isPlayerWinner = containsNumbers(cellsArray: playersCells.sorted(), possibilityArray: possibility)
            if isPlayerWinner {
                winner = "player"
                break
            }
            
            // check whether phone is the winner
            let isPhoneWinner = containsNumbers(cellsArray: phonesCells.sorted(), possibilityArray: possibility)
            if isPhoneWinner {
                winner = "phone"
                break
            }
        }
        
        return winner
    }
    
    func containsNumbers(cellsArray: [Int], possibilityArray: [Int]) -> Bool {
        var isHaving = false
        
        for i in possibilityArray {
            isHaving = cellsArray.contains(i)
            
            if !isHaving {
                break
            }
        }
        
        return isHaving
    }
    
    func endGame(message: String) {
        displayWinner(message)
    }
    
    func displayWinner(_ message: String) {
        
        let alert = UIAlertController(title: "Game Over", message: "\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func restart(_ sender: Any) {
        isPhonePlayer = false
        phonesCells = []
        playersCells = []
        winner = ""
        numberOfClicks = 0
        availableCells = [1,2,3,4,5,6,7,8,9]
        
        for button in buttonsArray {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = UIColor.white
        }
    }
}

