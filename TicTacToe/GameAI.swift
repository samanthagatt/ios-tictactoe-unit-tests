//
//  GameAI.swift
//  TicTacToe
//
//  Created by Andrew R Madsen on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

func game(board: GameBoard, isWonBy player: GameBoard.Mark) -> Bool {    
    
    // Check verticals
    // for each column
    // x is the column number
    for x in 0..<3 {
        var numMarksVertical = 0
        var numMarksHorizontal = 0
        for y in 0..<3 {
            if board[(x, y)] == player {
                numMarksVertical += 1
            }
            if board[(y, x)] == player {
                numMarksHorizontal += 1
            }
            
        }
        if numMarksVertical == 3 {
            return true
        }
        
        if numMarksHorizontal == 3 {
            return true
        }
    }
    
//    // horizontal
//    for y in 0..<3 {
//        // count up marks for each player
//        var numMarks = 0
//        for x in 0..<3 {
//            if board[(x, y)] == player {
//                numMarks += 1
//            }
//
//        }
//        if numMarks == 3 {
//            return true
//        }
//    }
    
    return false
}
