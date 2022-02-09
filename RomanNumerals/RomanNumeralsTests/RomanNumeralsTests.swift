//
//  RomanNumeralsTests.swift
//  RomanNumeralsTests
//
//  Created by Istvan Balogh on 09.02.22.
//

import XCTest
import RomanNumerals

class RomanNumberCalculator {
    
    static func value(from string: String) -> Int {
        0
    }
}

class RomanNumeralsTests: XCTestCase {

    func test_emptyString() {
        let romanNumbers = ""
        
        XCTAssertEqual(RomanNumberCalculator.value(from: romanNumbers), 0)
    }

}
