//
//  GameTests.swift
//  TicTacToeTests
//
//  Created by Samantha Gatt on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {
    
    var game = Game()
    
    override func setUp() {
        game = Game()
    }
    
    func testSwitchingPlayer() {
        try! game.makeMark(at: (0, 0))
        XCTAssertTrue(game.activePlayer == .o)
    }
    
    func testMakeMarkWhenPlayerWins() {
        /*
         x o x
         o x o
         x - -
        */
        for x in 0..<3 {
            for y in 0..<3 {
                if x == 2 && y > 0 {
                    XCTAssertTrue(game.gameIsOver)
                    XCTAssertThrowsError(try game.makeMark(at: (x, y)))
                } else {
                    XCTAssertNoThrow(try game.makeMark(at: (x, y)))
                }
            }
        }
        XCTAssertTrue(game.winningPlayer == .x)
        XCTAssertNil(game.activePlayer)
    }
    
    func testMakeMarkWhenCatsGame() {
        /*
         o x o
         x o x
         x o x
         */
        try! game.makeMark(at: (1, 0))
        try! game.makeMark(at: (0, 0))
        try! game.makeMark(at: (0, 1))
        try! game.makeMark(at: (1, 1))
        try! game.makeMark(at: (2, 1))
        try! game.makeMark(at: (2, 0))
        try! game.makeMark(at: (0, 2))
        try! game.makeMark(at: (1, 2))
        try! game.makeMark(at: (2, 2))
        
        XCTAssertThrowsError(try game.makeMark(at: (0, 0)))
        XCTAssertTrue(game.gameIsOver)
        XCTAssertNil(game.activePlayer)
        XCTAssertNil(game.winningPlayer)
    }
    
    func testRestart() {
        /*
         x - -
         - - -
         - - -
         */
        try! game.makeMark(at: (0, 0))
        game.restart()
        XCTAssertFalse(game.gameIsOver)
        XCTAssertTrue(game.board[(0, 0)] == nil)
        
        /*
         o x o
         x o x
         x o x
         */
        try! game.makeMark(at: (1, 0))
        try! game.makeMark(at: (0, 0))
        try! game.makeMark(at: (0, 1))
        try! game.makeMark(at: (1, 1))
        try! game.makeMark(at: (2, 1))
        try! game.makeMark(at: (2, 0))
        try! game.makeMark(at: (0, 2))
        try! game.makeMark(at: (1, 2))
        try! game.makeMark(at: (2, 2))
        
        game.restart()
        XCTAssertFalse(game.gameIsOver)
        XCTAssertTrue(game.board[(0, 0)] == nil)
        XCTAssertTrue(game.coordinates.count == 0)
    }
    
    func testUndoingWhenGameIsOver() {
        try! game.makeMark(at: (1, 0))
        try! game.makeMark(at: (0, 0))
        try! game.makeMark(at: (0, 1))
        try! game.makeMark(at: (1, 1))
        try! game.makeMark(at: (2, 1))
        try! game.makeMark(at: (2, 0))
        try! game.makeMark(at: (0, 2))
        try! game.makeMark(at: (1, 2))
        try! game.makeMark(at: (2, 2))
        
        let beforeUndo = game.coordinates
        game.undo()
        let afterUndo = game.coordinates
        
        XCTAssertTrue(beforeUndo.count == afterUndo.count)
        XCTAssertTrue(game.board[(2, 2)] == .x)
    }
    
    func testUndoing() {
        try! game.makeMark(at: (1, 0))
        try! game.makeMark(at: (0, 0))
        try! game.makeMark(at: (0, 1))
        try! game.makeMark(at: (1, 1))
        try! game.makeMark(at: (2, 1))
        try! game.makeMark(at: (2, 0))
        try! game.makeMark(at: (0, 2))
        try! game.makeMark(at: (1, 2))
        
        game.undo()
        XCTAssertTrue(game.board[(1, 2)] == nil)
        game.undo()
        XCTAssertTrue(game.board[(0, 2)] == nil)
        game.undo()
        XCTAssertTrue(game.board[(2, 0)] == nil)
        game.undo()
        XCTAssertTrue(game.board[(2, 1)] == nil)
        game.undo()
        XCTAssertTrue(game.board[(1, 1)] == nil)
        game.undo()
        XCTAssertTrue(game.board[(0, 1)] == nil)
        game.undo()
        XCTAssertTrue(game.board[(0, 0)] == nil)
        game.undo()
        XCTAssertTrue(game.board[(1, 0)] == nil)
    }
}
