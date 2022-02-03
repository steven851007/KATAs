//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Istvan Balogh on 03.02.22.
//

import XCTest
import Calculator

class StringCalculator {
    func add(numbers: String) -> Int {
        numbers
            .replacingOccurrences(of: "\n", with: ",")
            .split(separator: ",")
            .compactMap { Int($0) }
            .reduce(0,+)
    }
}

class CalculatorTests: XCTestCase {

    func test_add_emptyString() {
        XCTAssertEqual(StringCalculator().add(numbers: ""), 0)
    }
    
    func test_add_stringWithOneNumber() {
        XCTAssertEqual(StringCalculator().add(numbers: "1"), 1)
    }
    
    func test_add_stringWithTwoNumbers() {
        XCTAssertEqual(StringCalculator().add(numbers: "1,2"), 3)
    }
    
    func test_add_stringWithMoreNumbers() {
        XCTAssertEqual(StringCalculator().add(numbers: "1,2,3,4"), 10)
    }
    
    func test_add_stringWithNewLine() {
        XCTAssertEqual(StringCalculator().add(numbers: "1\n2,3,4"), 10)
    }

}
