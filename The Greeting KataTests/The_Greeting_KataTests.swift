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
        expect(name: "Bob", result: "Hello, Bob")
    }
    
    func test_greetingUnknown() {
        expect(name: nil, result: "Hello, my friend.")
        expect(names: [], result: "Hello, my friend.")
    }
    
    func test_shouting() {
        expect(name: "JERRY", result: "HELLO JERRY!")
    }
    
    func test_oneName() {
        expect(names: ["Jill"], result: "Hello, Jill")
    }
    
    func test_twoNames() {
        expect(names: ["Jill", "Jane"], result: "Hello, Jill and Jane.")
    }
    
    func test_multipleNames() {
        expect(names: ["Amy", "Brian", "Charlotte"], result: "Hello, Amy, Brian, and Charlotte.")
        expect(names: ["Amy", "Brian", "Charlotte", "Bob"], result: "Hello, Amy, Brian, Charlotte, and Bob.")
    }
    
    func test_multipleNamesWithShouting() {
        expect(names: ["Amy", "BRIAN", "Charlotte"], result: "Hello, Amy and Charlotte. AND HELLO BRIAN!")
        expect(names: ["Amy", "BRIAN", "Charlotte", "BOB"], result: "Hello, Amy and Charlotte. AND HELLO BRIAN, BOB!")
    }
    
    func test_nameWithComma() {
        expect(names: ["Bob", "Charlie, Dianne"], result: "Hello, Bob, Charlie, and Dianne.")
    }
    
    func test_namesWithQuotes() {
        expect(names: ["Bob", "\"Charlie, Dianne\""], result: "Hello, Bob, Charlie, and Dianne.")
    }
    
    // MARK: Helpers
    
    private func expect(name: String?, result: String, file: StaticString = #file, line: UInt = #line) {
        let greeting = Greeter().greet(name)
        XCTAssertEqual(greeting, result)
    }
    
    private func expect(names: [String], result: String, file: StaticString = #file, line: UInt = #line) {
        let greeting = Greeter().greet(names)
        XCTAssertEqual(greeting, result, file: file, line: line)
    }

}
