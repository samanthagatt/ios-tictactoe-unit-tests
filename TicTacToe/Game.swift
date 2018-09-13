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
    var lastPlayer: GameBoard.Mark? = nil
    var gameIsOver = false
    var winningPlayer: GameBoard.Mark? = nil
    var playedCoordinates: [Coordinate] = []
    var unplayedCoordinates: [Coordinate] = [(0, 0), (1, 0), (2, 0), (0, 1), (1, 1), (2, 1), (0, 2), (1, 2), (2, 2)]
    
    mutating func undo() {
        guard let coordinate = playedCoordinates.last, !gameIsOver else { return }
        board.erase(square: coordinate)
        playedCoordinates.removeLast()
    }
    
    mutating func restart() {
        board = GameBoard()
        gameIsOver = false
        activePlayer = .x
        lastPlayer = nil
        winningPlayer = nil
        playedCoordinates = []
    }
    
    mutating func makeMark(at coordinate: Coordinate) throws {
        guard let activePlayer = activePlayer else { throw NSError() }
        try board.place(mark: activePlayer, on: coordinate)
        
        playedCoordinates.append(coordinate)
        lastPlayer = activePlayer
        
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
    
    func minimax(isMax: Bool) -> Int {
        
        // game is over
        guard let activePlayer = activePlayer else {
            guard let lastPlayer = lastPlayer else { return 0 } // first turn -- shouldn't ever hit this?
            
            if lastPlayer == winningPlayer { // win
                return 1
            } else if winningPlayer == nil { // cat's game
                return 0
            } else { // loss
                return -1
            }
            
            if isMax {
                var bestEval = Int.min
                
            }
            
            return 0
        }
        
        
        
        return 0
    }
}
