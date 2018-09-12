//
//  Game.swift
//  TicTacToe
//
//  Created by Samantha Gatt on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Game {
    
    private(set) var board = GameBoard()
    var activePlayer: GameBoard.Mark? = .x
    var gameIsOver = false
    var winningPlayer: GameBoard.Mark? = nil
    
    mutating func restart() {
        board = GameBoard()
        gameIsOver = false
        activePlayer = .x
        winningPlayer = nil
    }
    
    mutating func makeMark(at coordinate: Coordinate) throws {
        guard let activePlayer = activePlayer else { throw NSError() }
        try board.place(mark: activePlayer, on: coordinate)
        
        if game(board: board, isWonBy: .x) {
            gameIsOver = true
            winningPlayer = .x
            self.activePlayer = nil
            return
        }
        if game(board: board, isWonBy: .o) {
            gameIsOver = true
            winningPlayer = .o
            self.activePlayer = nil
            return
        }
        
        if board.isFull {
            gameIsOver = true
            self.activePlayer = nil
            return
        }
        
        if self.activePlayer == .x {
            self.activePlayer = .o
        } else if self.activePlayer == .o {
            self.activePlayer = .x
        }
    }
}
