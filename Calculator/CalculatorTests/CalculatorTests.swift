//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Istvan Balogh on 03.02.22.
//

import XCTest
import Calculator

class StringCalculator {
    
    enum CalculatorError: Error, Equatable {
        case negativeNumber(message: String)
    }
    
    func add(numbers: String) throws -> Int {
        let separator = parseDelimiter(numbers)
        let intNumbers = numbers
            .replacingOccurrences(of: "//\(separator)\n", with: "")
            .replacingOccurrences(of: "\n", with: ",")
            .split(separator: separator)
            .compactMap { Int($0) }
            
        guard intNumbers.allSatisfy({ $0 > 0 }) else {
            let negative = intNumbers.first { $0<0 }!
            throw CalculatorError.negativeNumber(message: "Negatives not allowed: \(negative)")
        }
        
        return intNumbers.reduce(0,+)
    }
    
    private func parseDelimiter(_ numbers: String) -> Character {
        guard numbers.hasPrefix("//") else {
            return ","
        }
        return numbers[numbers.index(numbers.startIndex, offsetBy: 2)]
    }
}

class CalculatorTests: XCTestCase {

    func test_add_emptyString() {
        expect(numbers: "", result: 0)
    }
    
    func test_add_stringWithOneNumber() {
        expect(numbers: "1", result: 1)
    }
    
    func test_add_stringWithTwoNumbers() {
        expect(numbers: "1,2", result: 3)
    }
    
    func test_add_stringWithMoreNumbers() {
        expect(numbers: "1,2,3,4", result: 10)
    }
    
    func test_add_stringWithNewLine() {
        expect(numbers: "1\n2,3,4", result: 10)
    }
    
    func test_add_stringWithDifferentDelimiter() {
        expect(numbers: "//;\n1;2", result: 3)
    }
    
    func test_add_stringWithNegative() {
        let expectedError = StringCalculator.CalculatorError.negativeNumber(message: "Negatives not allowed: -4")
        expectError(numbers: "1,2,3,-4", expectedError: expectedError)
    }
    
    // MARK: Helpers
    
    private func expect(numbers: String, result: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(try StringCalculator().add(numbers: numbers), result, file: file, line: line)
    }
    
    private func expectError(numbers: String, expectedError: StringCalculator.CalculatorError, file: StaticString = #file, line: UInt = #line) {
        XCTAssertThrowsError(try StringCalculator().add(numbers: numbers)) { error in
            XCTAssertEqual(error as! StringCalculator.CalculatorError, expectedError)
        }
    }

}
