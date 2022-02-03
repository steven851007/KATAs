//
//  The_Greeting_KataTests.swift
//  The Greeting KataTests
//
//  Created by Istvan Balogh on 03.02.22.
//

import XCTest
import The_Greeting_Kata

func greet(_ name: String) -> String {
    "Hello, \(name)"
}

class The_Greeting_KataTests: XCTestCase {
    
    func test_simpleGreeting() {
        let greeting = greet("Bob")
        XCTAssertEqual(greeting, "Hello, Bob")
    }

}
