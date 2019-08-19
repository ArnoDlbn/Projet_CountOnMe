//
//  CalculatorTests.swift
//  CountOnMeTests
//
//  Created by Arnaud Dalbin on 21/07/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTests: XCTestCase {
    var calculator: Calculator!
    var result = [String]()
    var array = [String]()
    
    func testGivenDivision_WhenAdding0_ThenThrowsError() {
        array = ["2", "/"]
        calculator = Calculator(operations: array)
        XCTAssertThrowsError(try calculator.addNumber(label: "0"))
    }
    func testGivenOneOperand_WhenAddingNumber_ThenAdded() {
        array = ["2", "x"]
        do {
            calculator = Calculator(operations: array)
            let str = try calculator.addNumber(label: "3")
            XCTAssert(str == "2 x 3")
        } catch {
        }
    }
    func testGivenAResult_WhenAddingNumber_ThenAdded() {
        array = ["2", "x", "3", "=", "6"]
        do {
            calculator = Calculator(operations: array)
            let str = try calculator.addNumber(label: "1")
            XCTAssert(str == "1")
        } catch {
        }
    }
    func testGivenTwoOperands_WhenRemoveLastElement_ThenRemoved() {
        array = ["2", "/", "5"]
        do {
            calculator = Calculator(operations: array)
            let str = try calculator.removeLast()
            XCTAssert(str == "2 /")
        } catch {
        }
    }
    func testGivenNothing_WhenRemoveLastElement_ThenThrowsError() {
        array = []
        calculator = Calculator(operations: array)
        XCTAssertThrowsError(try calculator.removeLast())
    }
    func testGivenTwoOperands_WhenMultiplying_ThenMultiplied() {
        array = ["2", "x", "3"]
        do {
            calculator = Calculator(operations: array)
            result = try calculator.calculate()
            XCTAssert(result == ["6.0"])
            
            calculator = Calculator(operations: array)
            result = try calculator.reduceOperation(anOperator: "x")
            XCTAssert(result == ["6.0"])
        } catch {
        }
    }
    func testGivenTwoOperands_WhenDividing_ThenDivided() {
        array = ["4", "/", "2"]
        do {
            calculator = Calculator(operations: array)
            result = try calculator.calculate()
            XCTAssert(result == ["2.0"])
            
            calculator = Calculator(operations: array)
            result = try calculator.reduceOperation(anOperator: "/")
            XCTAssert(result == ["2.0"])
        } catch {
        }
    }
    func testGivenTwoOperands_WhenAdding_ThenAdded() {
        array = ["2", "+", "3"]
        do {
            calculator = Calculator(operations: array)
            result = try calculator.calculate()
            XCTAssert(result == ["5.0"])
            
            calculator = Calculator(operations: array)
            result = try calculator.reduceOperation(anOperator: "+")
            XCTAssert(result == ["5.0"])
        } catch {
        }
    }
    func testGivenTwoOperands_WhenSubtracting_ThenSubtracted() {
        array = ["3", "-", "2"]
        do {
            calculator = Calculator(operations: array)
            result = try calculator.calculate()
            XCTAssert(result == ["1.0"])
            
            calculator = Calculator(operations: array)
            result = try calculator.reduceOperation(anOperator: "-")
            XCTAssert(result == ["1.0"])
        } catch {
        }
    }
    func testGivenThreeOperands_WhenMultiplyingAndAdding_ThenMultipliedAndAdded() {
        array = ["2", "+", "3", "x", "4"]
        do {
            calculator = Calculator(operations: array)
            result = try calculator.calculate()
            XCTAssert(result == ["14.0"])
            
            calculator = Calculator(operations: array)
            result = try calculator.reduceOperation(anOperator: "x")
            XCTAssert(result == ["2", "+", "12.0"])
            
            calculator = Calculator(operations: array)
            result = try calculator.reduceOperation(anOperator: "+")
            XCTAssert(result == ["5.0", "x", "4"])
        } catch {
        }
    }
    func testGivenThreeOperands_WhenDividingAndSubtracting_ThenDividedAndSubtracted() {
        array = ["6", "-", "2", "/", "2"]
        do {
            calculator = Calculator(operations: array)
            result = try calculator.calculate()
            XCTAssert(result == ["5.0"])
            
            calculator = Calculator(operations: array)
            result = try calculator.reduceOperation(anOperator: "/")
            XCTAssert(result == ["6", "-", "1.0"])
            
            calculator = Calculator(operations: array)
            result = try calculator.reduceOperation(anOperator: "-")
            XCTAssert(result == ["4.0", "/", "2"])
        } catch {
        }
    }
    func testGivenFinishWithAnOperator_WhenTappingEqualButton_ThenThrowsError() {
        array = ["4", "-", "2", "+"]
        calculator = Calculator(operations: array)
        XCTAssertThrowsError(try calculator.calculate())
    }
    func testGivenOneElement_WhenTappingEqualButton_ThenThrowsError() {
        array = ["4"]
        calculator = Calculator(operations: array)
        XCTAssertThrowsError(try calculator.calculate())
    }
    func testGivenHaveAnUnidentifiedOperator_WhenTappingEqualButton_ThenThrowsError() {
        array = ["4", "u", "2"]
        calculator = Calculator(operations: array)
        XCTAssertThrowsError(try calculator.reduceOperation(anOperator: "u"))
    }
    func testGivenHaventAnOperator_WhenAddingAnOperator_ThenAddOperator() {
        array = ["6"]
        let sender = "/"        
        do {
            calculator = Calculator(operations: array)
            let str = try calculator.addOperator(label: sender)
            XCTAssert(str == " \(sender) ")
        } catch {
        }
    }
    func testGivenHaveAnOperator_WhenAddingAnotherOperator_ThenThrowsError() {
        let sender = "/"
        
        array = ["6", "+"]
        calculator = Calculator(operations: array)
        XCTAssertThrowsError(try calculator.addOperator(label: sender))
        
        array = ["6", "-"]
        calculator = Calculator(operations: array)
        XCTAssertThrowsError(try calculator.addOperator(label: sender))
        
        array = ["6", "/"]
        calculator = Calculator(operations: array)
        XCTAssertThrowsError(try calculator.addOperator(label: sender))
        
        array = ["6", "x"]
        calculator = Calculator(operations: array)
        XCTAssertThrowsError(try calculator.addOperator(label: sender))
    }
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
