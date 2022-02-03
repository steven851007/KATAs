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
        0
    }
}

class CalculatorTests: XCTestCase {

    func test_add_emptyString() {
        XCTAssertEqual(StringCalculator().add(numbers: ""), 0)
    }

}
