//
//  StringCalculator.swift
//  Calculator
//
//  Created by Istvan Balogh on 07.02.22.
//

import Foundation

public protocol StringCalculatorDelegate: AnyObject {
    func didFinishAdd()
}

public class StringCalculator {
    
    public enum CalculatorError: Error, Equatable {
        case negativeNumber(message: String)
    }
    
    public weak var delegate: StringCalculatorDelegate?
    public var calledCount = 0
    
    public init() { }
    
    public func add(numbers: String) throws -> Int {
        let result = try numbers
            .removeDelimiters()
            .replacingOccurrences(of: "\n", with: ",")
            .components(separatedBy: numbers.parseDelimiters())
            .compactMap(Int.init)
            .verifyAllNumbersPositive()
            .filter { $0 <= 1000 }
            .reduce(0,+)
        
        calledCount += 1
        delegate?.didFinishAdd()
        return result
    }
}

private extension String {
    
    func parseDelimiters() -> CharacterSet {
        guard self.hasPrefix("//") else {
            return CharacterSet(charactersIn: ",")
        }
        
        let thirdCharacter = String(self[self.index(self.startIndex, offsetBy: 2)])
        
        let delimiters = self
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
    
    private func delimitersnInBrackets() -> [String] {
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

private extension Array where Element == Int {
    
    func verifyAllNumbersPositive() throws -> [Int]{
        let negativeNumbers = self.filter({ $0 < 0 })
        
        if negativeNumbers.isEmpty {
            return self
        }
        
        let negativeNumbersString = negativeNumbers.reduce("") {
            $1 == self.last ?
            $0 + "\($1)" :
            $0 + "\($1), "
        }
        throw StringCalculator.CalculatorError.negativeNumber(message: "Negatives not allowed: \(negativeNumbersString)")
    }
}
