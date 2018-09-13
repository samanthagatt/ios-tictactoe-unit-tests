//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Andrew R Madsen on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, BoardViewControllerDelegate {
    
    // MARK: - Properties
    
    private var game = Game() {
        didSet {
            updateViews()
            boardViewController.board = game.board
        }
    }
    
    private var boardViewController: BoardViewController! {
        willSet {
            boardViewController?.delegate = nil
        }
        didSet {
            boardViewController?.board = game.board
            boardViewController?.delegate = self
        }
    }
    
    
    // MARK: - Outlets and Actions
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func undoMove(_ sender: Any) {
        game.undo()
    }
    @IBAction func restartGame(_ sender: Any) {
        game.restart()
    }
    
    
    // MARK: - Private
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        guard let player = game.activePlayer?.stringValue else {
            
            guard let winner = game.winningPlayer?.stringValue else {
                if game.gameIsOver { statusLabel.text = "Cat's game!" }
                return
            }
            
            statusLabel.text = "Player \(winner) won!"
            return
        }
        
        statusLabel.text = "Player \(player)'s turn"
    }
    
    
    // MARK: - BoardViewControllerDelegate
    
    func boardViewController(_ boardViewController: BoardViewController, markWasMadeAt coordinate: Coordinate) {
        guard !game.gameIsOver else {
            NSLog("Game is over")
            return
        }
        
        do {
            try game.makeMark(at: coordinate)
        } catch {
            NSLog("Illegal move")
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedBoard" {
            boardViewController = segue.destination as! BoardViewController
        }
    }
}
