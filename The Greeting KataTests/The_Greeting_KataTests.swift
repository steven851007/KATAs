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
    if name == name.uppercased() {
        return "HELLO \(name)!"
    }
    return "Hello, \(name)"
}

class The_Greeting_KataTests: XCTestCase {
    
    func test_simpleGreeting() {
        expect(name: "Bob", result: "Hello, Bob")
    }
    
    func test_greetingUnknown() {
        expect(name: nil, result: "Hello, my friend.")
    }
    
    func test_shouting() {
        expect(name: "JERRY", result: "HELLO JERRY!")
    }
    
    // MARK: Helpers
    
    private func expect(name: String?, result: String) {
        let greeting = greet(name)
        XCTAssertEqual(greeting, result)
    }

}
