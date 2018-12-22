//
//  ViewController.swift
//  Tic Tac Toc
//
//  Created by Pramodya Abeysinghe on 12/22/18.
//  Copyright © 2018 Pramodya Abeysinghe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isComputerActivePlayer: Bool = false
    var computer = [Int]()
    var player = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pressButton(_ sender: Any) {
        let selectedButton = sender as! UIButton
        playGame(button: selectedButton)
    }
    
    func playGame(button selectedButton: UIButton) {
        if isComputerActivePlayer {
            selectedButton.setTitle("O", for: UIControl.State.normal)
            selectedButton.backgroundColor = UIColor(red: 102/255, green: 250/255, blue: 51/255, alpha: 0.5)
            computer.append(selectedButton.tag)
            isComputerActivePlayer = !isComputerActivePlayer
        } else {
            selectedButton.setTitle("X", for: UIControl.State.normal)
            selectedButton.backgroundColor = UIColor(red: 32/255, green: 192/255, blue: 243/255, alpha: 0.5)
            player.append(selectedButton.tag)
            isComputerActivePlayer = !isComputerActivePlayer
        }
        selectedButton.isEnabled = false
    }
}

