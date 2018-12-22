//
//  ViewController.swift
//  Tic Tac Toc
//
//  Created by Pramodya Abeysinghe on 12/22/18.
//  Copyright © 2018 Pramodya Abeysinghe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isComputerPlayer: Bool = false
    var computer = [Int]()
    var player = [Int]()
    var buttonsArray: [UIButton] = []
    var winner: String = ""
    var numberOfClicks: Int = 0
    var availableNumbers = [Int]()
    
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
        // player's chance
        let selectedButton = sender as! UIButton
        playGame(button: selectedButton)
        numberOfClicks += 1
        
        winner = winnerOfTheGame()
        
        if winner == "player" {
            endGame(by: winner)
        }
        else {
            // phone's chance
            let computerSelectedButton = buttonsArray[selectRandomNumber() - 1]
            playGame(button: computerSelectedButton)
            
            winner = winnerOfTheGame()
            
            if winner == "computer" {
                endGame(by: winner)
            }
        }
        
        if numberOfClicks == 3 {
            endGame(by: "draw")
        }
        
        
    }
    
    func playGame(button selectedButton: UIButton) {

        if isComputerPlayer {
            selectedButton.setTitle("O", for: UIControl.State.normal)
            selectedButton.backgroundColor = UIColor(red: 102/255, green: 250/255, blue: 51/255, alpha: 0.5)
            computer.append(selectedButton.tag)
            isComputerPlayer = !isComputerPlayer
        } else {
            selectedButton.setTitle("X", for: UIControl.State.normal)
            selectedButton.backgroundColor = UIColor(red: 32/255, green: 192/255, blue: 243/255, alpha: 0.5)
            player.append(selectedButton.tag)
            isComputerPlayer = !isComputerPlayer
        }
        
        selectedButton.isEnabled = false
    }
    
    func selectRandomNumber() -> Int {
        
        for index in 1...9 {
            if computer.contains(index) || player.contains(index) {
                continue
            }
            availableNumbers.append(index)
        }
        let randomNumber = availableNumbers.randomElement()
        
        return randomNumber ?? 0
    }
    
    func winnerOfTheGame() -> String {
        for possibility in winningPossibilities {
            if computer.sorted() == possibility {
                winner = "computer"
                break
            } else if player.sorted() == possibility {
                winner = "player"
                break
            }
        }
        
        return winner
    }
    
    func endGame(by result: String) {
        displayWinner(result)
    }
    
    func displayWinner(_ result: String) {
        var message: String = ""
        
        if result == "player" {
            message = "You won the game"
        }
        else if result == "draw" {
            message = "Game is drawn"
        }
        else {
            message = "Phone won the game"
        }
        
        let alert = UIAlertController(title: "Winner", message: "\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true) {
            self.restartGame()
        }
    }
    
    func restartGame() {
        isComputerPlayer = false
        computer = []
        player = []
        availableNumbers = []
        winner = ""
        numberOfClicks = 0
        
        clearButtonTitles()
        print(computer)
        print(player)
        print(availableNumbers)
        print(winner)
        print(numberOfClicks)
    }
    
    func clearButtonTitles() {
        for button in buttonsArray {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = UIColor.white
        }
    }
}

