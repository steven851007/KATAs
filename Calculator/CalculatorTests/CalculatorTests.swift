//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Istvan Balogh on 03.02.22.
//

import XCTest
import Calculator

protocol StringCalculatorDelegate: AnyObject {
    func didFinishAdd()
}

class StringCalculator {
    
    enum CalculatorError: Error, Equatable {
        case negativeNumber(message: String)
    }
    
    weak var delegate: StringCalculatorDelegate?
    
    func add(numbers: String) throws -> Int {
        calledCount += 1
        let result = try numbers
            .removeDelimiters()
            .replacingOccurrences(of: "\n", with: ",")
            .components(separatedBy: parseDelimiter(numbers))
            .compactMap { Int($0) }
            .verifyAllNumbersPositive()
            .filter { $0 <= 1000 }
            .reduce(0,+)
        
        delegate?.didFinishAdd()
        return result
    }
    
    var calledCount = 0
    
    private func parseDelimiter(_ numbers: String) -> CharacterSet {
        guard numbers.hasPrefix("//") else {
            return CharacterSet(charactersIn: ",")
        }
        
        let thirdCharacter = String(numbers[numbers.index(numbers.startIndex, offsetBy: 2)])
        
        let delimiters = numbers
            .delimitersnInBrackets()
            .compactMap { parseDelimiterWithVariableLength($0) }
            .reduce("",+)
        
        let charactersString = delimiters.isEmpty ? thirdCharacter : delimiters
        
        return CharacterSet(charactersIn: charactersString)
    }
    
    private func parseDelimiterWithVariableLength(_ numbers: String) -> String? {
        guard let openingBracesIndex = numbers.firstIndex(of: "["),
              let closingBracesIndex = numbers.firstIndex(of: "]") else {
            return nil
        }
        
        return String(numbers[numbers.index(after: openingBracesIndex)..<closingBracesIndex])
    }
}

fileprivate extension String {
    
    func delimitersnInBrackets() -> [String] {
        let regex = try! NSRegularExpression(pattern: "\\[(.*?)\\]")
        let results = regex.matches(in: self,
                                    range: NSRange(self.startIndex..., in: self))
        return results.map {
            String(self[Range($0.range, in: self)!])
        }
    }
    
    func removeDelimiters() -> String {
        guard let indexOfNewLine = self.firstIndex(of: "\n"), self.hasPrefix("//") else {
            return self
        }
        return String(self.suffix(from: self.index(after: indexOfNewLine)))
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
    
    func test_add_withVariableDelimiterLenght() {
        expect(numbers: "//[***]\n1***2***3", result: 6)
    }
    
    func test_add_withMultipleDelimiters() {
        expect(numbers: "//[*][%]\n1*2%3", result: 6)
    }
    
    func test_add_stringWithNegative() {
        let expectedError = StringCalculator.CalculatorError.negativeNumber(message: "Negatives not allowed: -4")
        expectError(numbers: "1,2,3,-4", expectedError: expectedError)
    }
    
    func test_add_stringWithNegatives() {
        let expectedError = StringCalculator.CalculatorError.negativeNumber(message: "Negatives not allowed: -2, -3, -4")
        expectError(numbers: "1,-2,-3,-4", expectedError: expectedError)
    }
    
    func test_calledCount() throws {
        let (sut, _) = createSUT()
        XCTAssertEqual(0, sut.calledCount)
        
        let _ = try sut.add(numbers: "5")
        XCTAssertEqual(1, sut.calledCount)
        
        let _ = try sut.add(numbers: "//;\n1;2")
        XCTAssertEqual(2, sut.calledCount)
    }
    
    func test_addDelegate() throws {
        let (sut, delegateSpy) = createSUT()
        
        let _ = try sut.add(numbers: "5")
        
        XCTAssertEqual(delegateSpy.didFinishAddCalledCount, 1)
    }
    
    func test_add_numbersBiggerThan1000AreIgnored() {
        expect(numbers: "1,2,3,999", result: 1005)
        expect(numbers: "1,2,3,1000", result: 1006)
        expect(numbers: "1,2,3,1001", result: 6)
    }
    
    // MARK: Helpers
    
    private func createSUT() -> (StringCalculator, DelegateSpy) {
        let sut = StringCalculator()
        let delegateSpy = DelegateSpy()
        sut.delegate = delegateSpy
        
        return (sut, delegateSpy)
    }
    
    private func expect(numbers: String, result: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(try StringCalculator().add(numbers: numbers), result, file: file, line: line)
    }
    
    private func expectError(numbers: String, expectedError: StringCalculator.CalculatorError, file: StaticString = #file, line: UInt = #line) {
        XCTAssertThrowsError(try StringCalculator().add(numbers: numbers), file: file, line: line) { error in
            XCTAssertEqual(error as! StringCalculator.CalculatorError, expectedError, file: file, line: line)
        }
    }
    
    private class DelegateSpy: StringCalculatorDelegate {
        
        var didFinishAddCalledCount = 0
        
        func didFinishAdd() {
            didFinishAddCalledCount += 1
        }
    }

}

