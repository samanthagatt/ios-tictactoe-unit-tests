//
//  GameBoardTests.swift
//  TicTacToeTests
//
//  Created by Samantha Gatt on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest
// treats internal properties/functions like they are global (only for testing)
@testable import TicTacToe

class GameBoardTests: XCTestCase {
    
    // set up and tear down run before and after EACH test respectively
    // each test should be independent even though they are in the same class
    // order of tests should not matter
    // test test method names MUST start with "test"
    
    func testCreatingEmptyBoard() {
        let board = GameBoard()
        
        XCTAssertFalse(board.isFull)
        for x in 0..<3 {
            for y in 0..<3 {
                XCTAssertNil(board[(x, y)])
                
                // another way to do it
//                XCTAssert(board[(x, y)] == nil)
                
                // conceptual way to do it
//                if board[(x, y)] != nil {
//                    // Test failed
//                }
            }
        }
    }
    
    func testPlacingMarks() {
        var board = GameBoard()
        
        // DRY (Don't Repeat Yourself) doesn't exist in tests
        // a different approach from the for loops in testCreatingEmptyBoard()
        // this way if it fails, you know exactly which line(s) do(es)n't work
        XCTAssertNoThrow(try board.place(mark: .o, on: (0, 0)))
        XCTAssertEqual(board[(0, 0)], .o)
        XCTAssertNoThrow(try board.place(mark: .x, on: (1, 0)))
        XCTAssertEqual(board[(1, 0)], .x)
        XCTAssertNoThrow(try board.place(mark: .o, on: (2, 0)))
        XCTAssertEqual(board[(2, 0)], .o)
        XCTAssertNoThrow(try board.place(mark: .x, on: (0, 1)))
        XCTAssertEqual(board[(0, 1)], .x)
        XCTAssertNoThrow(try board.place(mark: .o, on: (1, 1)))
        XCTAssertEqual(board[(1, 1)], .o)
        XCTAssertNoThrow(try board.place(mark: .x, on: (2, 1)))
        XCTAssertEqual(board[(2, 1)], .x)
        XCTAssertNoThrow(try board.place(mark: .o, on: (0, 2)))
        XCTAssertEqual(board[(0, 2)], .o)
        XCTAssertNoThrow(try board.place(mark: .x, on: (1, 2)))
        XCTAssertEqual(board[(1, 2)], .x)
        XCTAssertNoThrow(try board.place(mark: .o, on: (2, 2)))
        XCTAssertEqual(board[(2, 2)], .o)
        
        XCTAssertThrowsError(try board.place(mark: .x, on: (0, 0))) { error in
            XCTAssertEqual(error as? GameBoardError, .invalidSquare)
        }
    }
    
    func testFillingBoard() {
        var board = GameBoard()
        for x in 0..<3 {
            for y in 0..<3 {
                XCTAssertFalse(board.isFull)
                try! board.place(mark: .x, on: (x, y))
            }
        }
        // board shouldn't be full until all coordinates are filled
        XCTAssertTrue(board.isFull)
    }
}
