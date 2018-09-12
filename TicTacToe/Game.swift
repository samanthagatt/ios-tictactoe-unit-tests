//
//  Game.swift
//  TicTacToe
//
//  Created by Samantha Gatt on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class Game {
    
    private(set) var board = GameBoard()
    var activePlayer: GameBoard.Mark? = .x
    var gameIsOver = false
    var winningPlayer: GameBoard.Mark? = nil
    
    func restart() {
        board = GameBoard()
        gameIsOver = false
        activePlayer = .x
        winningPlayer = nil
    }
    
    func makeMark(at coordinate: Coordinate) throws {
        guard let activePlayer = activePlayer else { return }
        try board.place(mark: activePlayer, on: coordinate)
        if board.isFull {
            gameIsOver = true
        }
    }
}
