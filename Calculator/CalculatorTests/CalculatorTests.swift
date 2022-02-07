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
        let delimiter = parseDelimiter(numbers)
        calledCount += 1
        return try numbers
            .replacingOccurrences(of: "//\(delimiter)\n", with: "")
            .replacingOccurrences(of: "\n", with: ",")
            .split(separator: delimiter)
            .compactMap { Int($0) }
            .verifyAllNumbersPositive()
            .reduce(0,+)
    }
    
    var calledCount = 0
    
    private func parseDelimiter(_ numbers: String) -> Character {
        guard numbers.hasPrefix("//") else {
            return ","
        }
        return numbers[numbers.index(numbers.startIndex, offsetBy: 2)]
    }
}

fileprivate extension Array where Element == Int {
    
    func verifyAllNumbersPositive() throws -> [Int]{
        let negativeNumbers = self.filter({ $0 < 0 })
        
        if negativeNumbers.isEmpty {
            return self
        }
        
        let numbersString = negativeNumbers.reduce("") {
            $1 == self.last ?
            $0 + "\($1)" :
            $0 + "\($1), "
        }
        throw StringCalculator.CalculatorError.negativeNumber(message: "Negatives not allowed: \(numbersString)")
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
    
    func test_add_stringWithNegatives() {
        let expectedError = StringCalculator.CalculatorError.negativeNumber(message: "Negatives not allowed: -2, -3, -4")
        expectError(numbers: "1,-2,-3,-4", expectedError: expectedError)
    }
    
    func test_calledCount() {
        let sut = StringCalculator()
        XCTAssertEqual(0, sut.calledCount)
        
        expect(numbers: "1", result: 1, calculator: sut)
        XCTAssertEqual(1, sut.calledCount)
        
        expect(numbers: "//;\n1;2", result: 3, calculator: sut)
        XCTAssertEqual(2, sut.calledCount)
    }
    
    // MARK: Helpers
    
    private func expect(numbers: String, result: Int, calculator: StringCalculator = StringCalculator(), file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(try calculator.add(numbers: numbers), result, file: file, line: line)
    }
    
    private func expectError(numbers: String, expectedError: StringCalculator.CalculatorError, calculator: StringCalculator = StringCalculator(), file: StaticString = #file, line: UInt = #line) {
        XCTAssertThrowsError(try calculator.add(numbers: numbers), file: file, line: line) { error in
            XCTAssertEqual(error as! StringCalculator.CalculatorError, expectedError, file: file, line: line)
        }
    }

}
