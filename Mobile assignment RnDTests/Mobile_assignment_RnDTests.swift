//
//  Mobile_assignment_RnDTests.swift
//  Mobile assignment RnDTests
//
//  Created by Hazem Maher on 8/9/18.
//  Copyright © 2018 Hazem Maher. All rights reserved.
//

import XCTest
@testable import Mobile_assignment_RnD

class Mobile_assignment_RnDTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTrieSearch() {
        
        let trie = Trie()
        trie.insert(word: "cairo")
        trie.insert(word: "tanta")
        trie.insert(word: "alex")
        let wordsAll = trie.findWordsWithPrefix(prefix: "")
        XCTAssertEqual(wordsAll.sorted(), ["cairo", "tanta", "alex"])
        let words = trie.findWordsWithPrefix(prefix: "al")
        XCTAssertEqual(words, ["alex"])
        trie.insert(word: "alexandria")
        let words2 = trie.findWordsWithPrefix(prefix: "alex")
        XCTAssertEqual(words2, ["alex", "alexandria"])
        let noWords = trie.findWordsWithPrefix(prefix: "zz")
        XCTAssertEqual(noWords, [])
        
    }
    
}
