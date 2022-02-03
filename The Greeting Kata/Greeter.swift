//
//  Greeter.swift
//  The Greeting Kata
//
//  Created by Istvan Balogh on 03.02.22.
//

import Foundation

public final class Greeter {
    
    public init() {}
    
    public func greet(_ name: String?) -> String {
        guard let name = name else {
            return "Hello, my friend."
        }
        
        if name == name.uppercased() {
            return "HELLO \(name)!"
        }
        return "Hello, \(name)"
    }
    
    public func greet(_ names: [String]) -> String {
        let groupedNames = names
            .removeQuotes()
            .handleCommas()
            .separateNamesByCapitalization()
        
        return greet(lowercasedNames: groupedNames.lowercased) + greet(uppercasedNames: groupedNames.uppercased)
    }

    private func greet(uppercasedNames: [String]) -> String  {
        guard !uppercasedNames.isEmpty else { return "" }
        return uppercasedNames.reduce(" AND HELLO") { partialResult, name in
            let separator = name == uppercasedNames.last ? "!" : ","
            return partialResult + " " + name + separator
        }
    }

    private func greet(lowercasedNames names: [String]) -> String {
        switch names.count {
        case 0 :
            return greet(nil)
        case 1:
            return greet(names.first!)
        case 2:
            return "Hello, \(names.first!) and \(names.last!)."
        default:
            return names.reduce("Hello") { partialResult, name in
                name == names.last ?
                partialResult + ", and " + name + "." :
                partialResult + ", " + name
            }
        }
    }
}

fileprivate extension Array where Element == String {
    func separateNamesByCapitalization() -> (lowercased: [String], uppercased: [String]) {
        let upperCasedNames = self.filter { name in
            name == name.uppercased()
        }
        let lowerCasedNames = self.filter {
            !upperCasedNames.contains($0)
        }
        return (lowerCasedNames, upperCasedNames)
    }
    
    func handleCommas() -> [String] {
        let smallNames = Array(self.map { name in
            name.components(separatedBy: ", ")
        }.joined())
        
        return smallNames
    }
    
    func removeQuotes() -> [String] {
        let noQuetes = self.map { name in
            name.replacingOccurrences(of: "\"", with: "")
        }
        return noQuetes
    }
}
