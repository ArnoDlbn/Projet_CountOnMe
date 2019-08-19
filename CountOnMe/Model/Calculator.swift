//
//  Calculator.swift
//  CountOnMe
//
//  Created by Arnaud Dalbin on 08/07/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum CalculatorError : Error {
    case expressionIsNotCorrect
    case expressionDontHaveEnoughElement
    case cantAddOperator
    case cantRemoveLast
    case unknownOperator
    case cantAdd0
}

class Calculator {
    // Copy of elements
    var operationsToReduce: [String]
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return operationsToReduce.last != "+" && operationsToReduce.last != "-" && operationsToReduce.last != "x" && operationsToReduce.last != "/"
    }
    var expressionHaveEnoughElement: Bool {
        return operationsToReduce.count >= 3
    }
    var canAddOperator: Bool {
        return operationsToReduce.last != "+" && operationsToReduce.last != "-" && operationsToReduce.last != "x" && operationsToReduce.last != "/"
    }
    var canRemoveLast: Bool {
        return operationsToReduce.count >= 1
    }
    var expressionHaveResult: Bool {
        return operationsToReduce.firstIndex(of: "=") != nil
    }
    var canAdd0: Bool {
        return operationsToReduce.firstIndex(of: "/") == nil
    }
    func addNumber(label: String) throws -> String {
        if expressionHaveResult {
            operationsToReduce = [label]
        } else if label == "0" {
            guard canAdd0 else {
                throw CalculatorError.cantAdd0
            }
        } else {
            self.operationsToReduce.append(label)
        }
        return operationsToReduce.joined(separator: " ")
    }
    func removeLast() throws -> String {
        // Throws error
        guard canRemoveLast else {
            throw CalculatorError.cantRemoveLast
        }
        // Remove last element
        operationsToReduce.removeLast()
        return operationsToReduce.joined(separator: " ")
    }
    func addOperator(label: String) throws -> String {
        // Throws error
        guard canAddOperator else {
            throw CalculatorError.cantAddOperator
        }
        // Add operand
        return (" \(label) ")
    }
    func calculate() throws -> [String] {
        // Throws error
        guard expressionIsCorrect else {
            throw CalculatorError.expressionIsNotCorrect
        }
        guard expressionHaveEnoughElement else {
            throw CalculatorError.expressionDontHaveEnoughElement
        }
        // Iterate over operations while an operand still here
        while operationsToReduce.firstIndex(of: "x") != nil {
            operationsToReduce = try reduceOperation(anOperator: "x")
        }
        while operationsToReduce.firstIndex(of: "/") != nil {
            operationsToReduce = try reduceOperation(anOperator: "/")
        }
        while operationsToReduce.firstIndex(of: "-") != nil {
            operationsToReduce = try reduceOperation(anOperator: "-")
        }
        while operationsToReduce.firstIndex(of: "+") != nil {
            operationsToReduce = try reduceOperation(anOperator: "+")
        }
        return operationsToReduce
    }

    func reduceOperation(anOperator: String) throws -> [String] {
        let result: Double
        let index = operationsToReduce.firstIndex(of: anOperator)
        if index != nil {
            let left = Double(operationsToReduce[index! - 1])!
            let right = Double(operationsToReduce[index! + 1])!
            switch anOperator {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            default: throw CalculatorError.unknownOperator
            }
            operationsToReduce[index!] = "\(result)"
            operationsToReduce.remove(at: index! + 1)
            operationsToReduce.remove(at: index! - 1)
        }
        return operationsToReduce
    }
    init(operations: [String]) {
        operationsToReduce = operations
    }
}
