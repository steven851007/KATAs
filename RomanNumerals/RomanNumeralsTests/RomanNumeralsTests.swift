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
        var finalValue = 0
        var prevCharValue = 0
        var currentCharValue = Int.max
        
        string.forEach { character in
            prevCharValue = currentCharValue
            currentCharValue = self.value(of: character)
            
            if prevCharValue < currentCharValue {
                finalValue += currentCharValue - 2*prevCharValue
            } else {
                finalValue += currentCharValue
            }
            
        }
        return finalValue
    }
    private static func value(of character: Character) -> Int {
        switch character {
        case "I":
            return 1
        case "V":
            return 5
        case "X":
            return 10
        case "L":
            return 50
        case "C":
            return 100
        case "D":
            return 500
        case "M":
            return 1000
        default:
            return 0
        }
    }
}

class RomanNumeralsTests: XCTestCase {

    func test_emptyString() {
        let romanNumbers = ""
        
        XCTAssertEqual(RomanNumberCalculator.value(from: romanNumbers), 0)
    }
    
    func test_singleDigits() {
        let romanNumbers = [("I", 1), ("V", 5), ("X", 10), ("L", 50), ("C", 100), ("D", 500), ("M", 1000)]
        
        for value in romanNumbers {
            XCTAssertEqual(RomanNumberCalculator.value(from: value.0), value.1)
        }
    }
    
    func test_twoDigitsAddition() {
        let romanNumbers = [("II", 2), ("VI", 6), ("XI", 11), ("LX", 60), ("CL", 150), ("DI", 501), ("MD", 1500)]
        
        for value in romanNumbers {
            XCTAssertEqual(RomanNumberCalculator.value(from: value.0), value.1)
        }
    }
    
    func test_twoDigitsSubstraction() {
        let romanNumbers = [("IV", 4), ("IX", 9), ("XL", 40)]
        
        for value in romanNumbers {
            XCTAssertEqual(RomanNumberCalculator.value(from: value.0), value.1)
        }
    }
    
    func test_threeDigitsAddition() {
        let romanNumbers = [("III", 3), ("VII", 7), ("XII", 12), ("LXX", 70), ("CLX", 160), ("DXI", 511), ("MDL", 1550)]
        
        for value in romanNumbers {
            XCTAssertEqual(RomanNumberCalculator.value(from: value.0), value.1)
        }
    }
    
    func test_oneToTen() {
        let romanNumbers = [
            ("I", 1),
            ("II", 2),
            ("III", 3),
            ("IV", 4),
            ("V", 5),
            ("VI", 6),
            ("VII", 7),
            ("VIII", 8),
            ("IX", 9),
            ("X", 10)
        ]
        
        for value in romanNumbers {
            XCTAssertEqual(RomanNumberCalculator.value(from: value.0), value.1)
        }
    }
    
    func test_tenToTwenty() {
        let romanNumbers = [
            ("XI", 11),
            ("XII", 12),
            ("XIII", 13),
            ("XIV", 14),
            ("XV", 15),
            ("XVI", 16),
            ("XVII", 17),
            ("XVIII", 18),
            ("XIX", 19),
            ("XX", 20)
        ]
        
        for value in romanNumbers {
            XCTAssertEqual(RomanNumberCalculator.value(from: value.0), value.1)
        }
    }
    
    func test_twentyToThirty() {
        let romanNumbers = [
            ("XXI", 21),
            ("XXII", 22),
            ("XXIII", 23),
            ("XXIV", 24),
            ("XXV", 25),
            ("XXVI", 26),
            ("XXVII", 27),
            ("XXVIII", 28),
            ("XXIX", 29),
            ("XXX", 30)
        ]
        
        for value in romanNumbers {
            XCTAssertEqual(RomanNumberCalculator.value(from: value.0), value.1)
        }
    }
    
    func test_thirtyToForty() {
        let romanNumbers = [
            ("XXXI", 31),
            ("XXXII", 32),
            ("XXXIII", 33),
            ("XXXIV", 34),
            ("XXXV", 35),
            ("XXXVI", 36),
            ("XXXVII", 37),
            ("XXXVIII", 38),
            ("XXXIX", 39),
            ("XL", 40)
        ]
        
        for value in romanNumbers {
            XCTAssertEqual(RomanNumberCalculator.value(from: value.0), value.1)
        }
    }
    
    func test_fortyToFifty() {
        let romanNumbers = [
            ("XLI", 41),
            ("XLII", 42),
            ("XLIII", 43),
            ("XLIV", 44),
            ("XLV", 45),
            ("XLVI", 46),
            ("XLVII", 47),
            ("XLVIII", 48),
            ("XLIX", 49),
            ("L", 50)
        ]
        
        for value in romanNumbers {
            XCTAssertEqual(RomanNumberCalculator.value(from: value.0), value.1)
        }
    }
    
    func test_houndreds() {
        let romanNumbers = [
            ("C", 100),
            ("CC", 200),
            ("CCC", 300),
            ("CD", 400),
            ("D", 500),
            ("DC", 600),
            ("DCC", 700),
            ("DCCC", 800),
            ("CM", 900),
            ("M", 1000)
        ]
        
        for value in romanNumbers {
            XCTAssertEqual(RomanNumberCalculator.value(from: value.0), value.1)
        }
    }
    
    func test_bigNumbers() {
        let romanNumbers = [
            ("MMVI", 2006),
            ("MCMXLIV", 1944),
            ("DCCLXXXIX", 789)
        ]
        
        for value in romanNumbers {
            XCTAssertEqual(RomanNumberCalculator.value(from: value.0), value.1)
        }
    }
}
