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
    var coordinates: [Coordinate] = []
    
    mutating func undo() {
        guard let coordinate = coordinates.last, !gameIsOver else { return }
        board.erase(square: coordinate)
        coordinates.removeLast()
    }
    
    mutating func restart() {
        board = GameBoard()
        gameIsOver = false
        activePlayer = .x
        winningPlayer = nil
        coordinates = []
    }
    
    mutating func makeMark(at coordinate: Coordinate) throws {
        guard let activePlayer = activePlayer else { throw NSError() }
        try board.place(mark: activePlayer, on: coordinate)
        coordinates.append(coordinate)
        
        if checkGame(board: board, isWonBy: .x) {
            gameIsOver = true
            winningPlayer = .x
            self.activePlayer = nil
            return
        }
        if checkGame(board: board, isWonBy: .o) {
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
