//
//  The_Greeting_KataTests.swift
//  The Greeting KataTests
//
//  Created by Istvan Balogh on 03.02.22.
//

import XCTest
import The_Greeting_Kata

func greet(_ names: [String]) -> String {
    let noQuetoesNames = removeQuotes(names)
    let capitalNames = noQuetoesNames.filter { name in
        name == name.uppercased()
    }
    let smallNames = Array(noQuetoesNames.filter {
        !capitalNames.contains($0)
    }.map { name in
        name.components(separatedBy: ", ")
    }.joined())
    
    if capitalNames.isEmpty {
        return greet(smallNames: smallNames)
    }
    
    return greet(smallNames: smallNames) + greet(shoutedNames: capitalNames)
}

private func removeQuotes(_ names: [String]) -> [String] {
    let noQuetes = names.map { name in
        name.replacingOccurrences(of: "\"", with: "")
    }
    return noQuetes
}

private func greet(shoutedNames: [String]) -> String {
    " AND HELLO \(shoutedNames.first!)!"
}

private func greet(smallNames names: [String]) -> String {
    if names.count == 2 {
        return "Hello, \(names.first!) and \(names.last!)."
    }
    let greeting = names.reduce("Hello") { partialResult, name in
        if name == names.last {
            return partialResult + ", and " + name + "."
        }
        return partialResult + ", " + name
    }
    return greeting
}

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
    
    func test_twoNames() {
        expect(names: ["Jill", "Jane"], result: "Hello, Jill and Jane.")
    }
    
    func test_multipleNames() {
        expect(names: ["Amy", "Brian", "Charlotte"], result: "Hello, Amy, Brian, and Charlotte.")
    }
    
    func test_multipleNamesWithShouting() {
        expect(names: ["Amy", "BRIAN", "Charlotte"], result: "Hello, Amy and Charlotte. AND HELLO BRIAN!")
    }
    
    func test_nameWithComma() {
        expect(names: ["Bob", "Charlie, Dianne"], result: "Hello, Bob, Charlie, and Dianne.")
    }
    
    func test_namesWithQuotes() {
        expect(names: ["Bob", "\"Charlie, Dianne\""], result: "Hello, Bob, Charlie, and Dianne.")
    }
    
    // MARK: Helpers
    
    private func expect(name: String?, result: String, file: StaticString = #file, line: UInt = #line) {
        let greeting = greet(name)
        XCTAssertEqual(greeting, result)
    }
    
    private func expect(names: [String], result: String, file: StaticString = #file, line: UInt = #line) {
        let greeting = greet(names)
        XCTAssertEqual(greeting, result, file: file, line: line)
    }

}
