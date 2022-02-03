//
//  The_Greeting_KataTests.swift
//  The Greeting KataTests
//
//  Created by Istvan Balogh on 03.02.22.
//

import XCTest
import The_Greeting_Kata

func greet(_ name: String?) -> String {
    guard let name = name else {
        return "Hello, my friend."
    }
    return "Hello, \(name)"
}

class The_Greeting_KataTests: XCTestCase {
    
    func test_simpleGreeting() {
        let greeting = greet("Bob")
        XCTAssertEqual(greeting, "Hello, Bob")
    }
    
    func test_greetingUnknown() {
        let greeting = greet(nil)
        XCTAssertEqual(greeting, "Hello, my friend.")
    }

}
