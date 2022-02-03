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
        guard !numbers.isEmpty else {
            return 0
        }
        return 1
    }
}

class CalculatorTests: XCTestCase {

    func test_add_emptyString() {
        XCTAssertEqual(StringCalculator().add(numbers: ""), 0)
    }
    
    func test_add_stringWithOneNumber() {
        XCTAssertEqual(StringCalculator().add(numbers: "1"), 1)
    }

}
