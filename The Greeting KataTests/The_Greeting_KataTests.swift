//
//  The_Greeting_KataTests.swift
//  The Greeting KataTests
//
//  Created by Istvan Balogh on 03.02.22.
//

import XCTest
import The_Greeting_Kata

class The_Greeting_KataTests: XCTestCase {
    
    func test_simpleGreeting() {
        expect(name: "Bob", greeting: "Hello, Bob")
    }
    
    func test_greetingUnknown() {
        expect(name: nil, greeting: "Hello, my friend.")
        expect(names: [], greeting: "Hello, my friend.")
    }
    
    func test_shouting() {
        expect(name: "JERRY", greeting: "HELLO JERRY!")
    }
    
    func test_oneName() {
        expect(names: ["Jill"], greeting: "Hello, Jill")
    }
    
    func test_twoNames() {
        expect(names: ["Jill", "Jane"], greeting: "Hello, Jill and Jane.")
    }
    
    func test_multipleNames() {
        expect(names: ["Amy", "Brian", "Charlotte"], greeting: "Hello, Amy, Brian, and Charlotte.")
        expect(names: ["Amy", "Brian", "Charlotte", "Bob"], greeting: "Hello, Amy, Brian, Charlotte, and Bob.")
    }
    
    func test_multipleNamesWithShouting() {
        expect(names: ["Amy", "BRIAN", "Charlotte"], greeting: "Hello, Amy and Charlotte. AND HELLO BRIAN!")
        expect(names: ["Amy", "BRIAN", "Charlotte", "BOB"], greeting: "Hello, Amy and Charlotte. AND HELLO BRIAN, BOB!")
    }
    
    func test_nameWithComma() {
        expect(names: ["Bob", "Charlie, Dianne"], greeting: "Hello, Bob, Charlie, and Dianne.")
    }
    
    func test_namesWithQuotes() {
        expect(names: ["Bob", "\"Charlie, Dianne\""], greeting: "Hello, Bob, Charlie, and Dianne.")
    }
    
    // MARK: Helpers
    
    private func expect(name: String?, greeting: String, file: StaticString = #file, line: UInt = #line) {
        let greeting = Greeter().greet(name)
        XCTAssertEqual(greeting, greeting)
    }
    
    private func expect(names: [String], greeting: String, file: StaticString = #file, line: UInt = #line) {
        let greeting = Greeter().greet(names)
        XCTAssertEqual(greeting, greeting, file: file, line: line)
    }

}
