//
//  InputValidationTests.swift
//  InputValidationTests
//
//  Created by Panayot Panayotov on 22/09/2017.
//  Copyright © 2017 Panayot Panayotov. All rights reserved.
//

import XCTest

@testable import InputValidation

class InputValidationTests: XCTestCase {
    
    let testValue = 10.00
    
    func testMatches() {
        XCTAssertTrue((1321321 as InputValue).matches(regex:"^[0-9]+$"), "Expected 1321321.matches(regex: '^[0-9]+$') to be true")
        XCTAssertTrue(("askdjhask" as InputValue).matches(regex: "^[a-z]+$"), "Expected askdjhask.matches(regex: '^[a-z]+$') to be true")
        XCTAssertTrue(("askSSdjhDask" as InputValue).matches(regex: "^[a-zA-Z]+$"), "Expected askSSdjhDask.matches(regex: '^[a-zA-Z]+$') to be true")
        XCTAssertFalse(("askSSdjhDask"as InputValue).matches(regex: "^[a-zA-Z]{1,5}$"), "Expected askSSdjhDask.matches(regex: '^[a-zA-Z]{1,5}$') to be false")
        XCTAssertFalse((1321321 as InputValue).matches(regex: "^[a-zA-Z]+$"), "Expected 1321321.matches(regex: '^[a-zA-Z]+$') to be false")
        XCTAssertFalse((1321321 as InputValue).matches(regex: "^[a-zA-Z]+$"), "Expected 1321321.matches(regex: '^[a-zA-Z]+$') to be false")
        XCTAssertFalse(("askSSdjhDask" as InputValue).matches(regex: "^[0-9]+$"), "Expected askSSdjhDask.matches(regex: '^[0-9]+$') to be false")
        XCTAssertFalse((true as InputValue).matches(regex: "^[0-9]+$"), "Expected true.matches(regex: '^[0-9]+$') to be false")
        XCTAssertFalse((false as InputValue).matches(regex: "^[0-9]+$"), "Expected false.matches(regex: '^[0-9]+$') to be false")
    }
    
    func testNumber() {
        makeValueTypeTest(type: .number)
        makeGenericInputValidationTest(type: .number)
    }
    
    func testFloat() {
        makeValueTypeTest(type: .float)
        makeGenericInputValidationTest(type: .float)
    }
    
    func testInt() {
        makeValueTypeTest(type: .int)
        makeGenericInputValidationTest(type: .int)
    }
    
    func testString() {
        makeValueTypeTest(type: .string)
    }
    
    func testBool() {
        XCTAssertTrue(true.toBool!, "Expected true.toBool to be true")
        XCTAssertFalse(false.toBool!, "Expected false.toBool to be false")
        XCTAssertTrue("true".toBool!, "Expected 'true'.toBool to be 'true'")
        XCTAssertFalse("false".toBool!, "Expected 'false'.toBool to be false")
        XCTAssertTrue("TRUE".toBool!, "Expected 'TRUE'.toBool to be 'true'")
        XCTAssertFalse("FALSE".toBool!, "Expected 'FALSE'.toBool to be false")
        XCTAssertTrue("True".toBool!, "Expected 'True'.toBool to be 'true'")
        XCTAssertFalse("False".toBool!, "Expected 'False'.toBool to be false")
        makeValueTypeTest(type: .bool)
    }
    
    func testDouble() {
        makeValueTypeTest(type: .double)
        makeGenericInputValidationTest(type: .double)
    }
    
    func makeValueTypeTest(type: ValueType) {
        
        func validateNumber(test: InputValue) {
            XCTAssertTrue(test.isNumber, "Expected NSNumber to be of type number")
            XCTAssertFalse(test.isBool, "Expected NSNumber to be of type number not bool")
            XCTAssertFalse(test.isInt, "Expected NSNumber to be of type number not int")
            XCTAssertFalse(test.isFloat, "Expected NSNumber to be of type number not float")
            XCTAssertFalse(test.isDouble, "Expected NSNumber to be of type number not double")
            XCTAssertFalse(test.isString, "Expected NSNumber to be of type number not string")
        }
        
        func validateFloat(test: InputValue) {
            XCTAssertFalse(test.isNumber, "Expected Float to be of type Float not number")
            XCTAssertFalse(test.isBool, "Expected Float to be of type number not bool")
            XCTAssertFalse(test.isInt, "Expected Float to be of type number not int")
            XCTAssertTrue(test.isFloat, "Expected Float to be of type float")
            XCTAssertFalse(test.isDouble, "Expected Float to be of type number not double")
            XCTAssertFalse(test.isString, "Expected Float to be of type number not string")
        }
        
        func validateString(test: InputValue) {
            XCTAssertFalse(test.isNumber, "Expected String to be of type String not number")
            XCTAssertFalse(test.isBool, "Expected String to be of type string not bool")
            XCTAssertFalse(test.isInt, "Expected String to be of type string not int")
            XCTAssertFalse(test.isFloat, "Expected String to be of type string not float")
            XCTAssertFalse(test.isDouble, "Expected String to be of type string not double")
            XCTAssertTrue(test.isString, "Expected String to be of type string")
        }
        
        func validateDouble(test: InputValue) {
            XCTAssertFalse(test.isNumber, "Expected Double to be of type double not number")
            XCTAssertFalse(test.isBool, "Expected Double to be of type double not bool")
            XCTAssertFalse(test.isInt, "Expected Double to be of type double not int")
            XCTAssertFalse(test.isFloat, "Expected Double to be of type double not float")
            XCTAssertTrue(test.isDouble, "Expected Double to be of type double")
            XCTAssertFalse(test.isString, "Expected Double to be of type double not string")
        }
        
        func validateInt(test: InputValue) {
            XCTAssertFalse(test.isNumber, "Expected Int to be of type int not number")
            XCTAssertFalse(test.isBool, "Expected Int to be of type int not bool")
            XCTAssertTrue(test.isInt, "Expected Int to be of type int")
            XCTAssertFalse(test.isFloat, "Expected Int to be of type int not float")
            XCTAssertFalse(test.isDouble, "Expected Int to be of type int not double")
            XCTAssertFalse(test.isString, "Expected Int to be of type int not string")
        }
        
        func validateBool(test: InputValue) {
            XCTAssertFalse(test.isNumber, "Expected Bool to be of type bool not number")
            XCTAssertTrue(test.isBool, "Expected Bool to be of type bool")
            XCTAssertFalse(test.isInt, "Expected Bool to be of type bool not int")
            XCTAssertFalse(test.isFloat, "Expected Bool to be of type bool not float")
            XCTAssertFalse(test.isDouble, "Expected Bool to be of type bool not double")
            XCTAssertFalse(test.isString, "Expected Bool to be of type bool not string")
        }
        
        switch type {
        case .number:
            validateNumber(test: NSNumber(value: testValue))
        case .float:
            validateFloat(test: Float(testValue))
        case .string:
            validateString(test: String(testValue))
        case .double:
            validateDouble(test: Double(testValue))
        case .int:
            validateInt(test: Int(testValue))
        case .bool:
            validateBool(test: true)
        }
        
        
    }
    
    func makeGenericInputValidationTest(type: ValueType) {
        
        switch type {
        case .number:
            performTestWith(test: NSNumber(value: testValue))
        case .float:
            performTestWith(test: Float(testValue))
        case .double:
            performTestWith(test: Double(testValue))
        case .int:
            performTestWith(test: Int(testValue))
        default:
            XCTFail("Can't test boolean or string value types with this test method")
        }
        
    }
    
    func performTestWith(test: InputValue) {
        
        XCTAssertNil(test.toBool, "Expected \(test.type.rawValue)(\(testValue)).toBool to be nil")
        XCTAssertEqual(test.toInt, Int(testValue), "Expected \(test.type.rawValue)(\(testValue)).toInt to be equal to Int(\(testValue))")
        XCTAssertEqual(test.toFloat, Float(testValue), "Expected \(test.type.rawValue)(\(testValue)).toFloat to be equal to Float(\(testValue))")
        XCTAssertEqual(test.toDouble, Double(testValue), "Expected \(test.type.rawValue)(\(testValue)).toDouble to be equal to Double(\(testValue))")
        XCTAssertFalse(test.isEmpty, "Expected \(test.type.rawValue)(\(testValue)).isEmpty to be false")
        
        if test.isInt {
            XCTAssertEqual(test.toString, String(Int(testValue)), "Expected \(test.type.rawValue)(\(testValue)).toString to be equal to String(\(String(Int(testValue))))")
        } else if test.isFloat {
            XCTAssertEqual(test.toString, String(Float(testValue)), "Expected \(test.type.rawValue)(\(testValue)).toString to be equal to String(\(String(Float(testValue))))")
        } else if test.isDouble {
            XCTAssertEqual(test.toString, String(Double(testValue)), "Expected \(test.type.rawValue)(\(testValue)).toString to be equal to String(\(String(Double(testValue))))")
        } else if test.isNumber {
            XCTAssertEqual(test.toString, String(describing: NSNumber(value: testValue)), "Expected \(test.type.rawValue)(\(testValue)).toString to be equal to String(\(String(describing: NSNumber(value: testValue))))")
        }
        
        XCTAssertTrue(test.isBetween(min: Int(9), max: Int(11)), "Expected \(test.type.rawValue)(\(testValue)).isBetween to be true for Int(9) - Int(11)")
        XCTAssertTrue(test.isBetween(min: Float(9), max: Float(11.0)), "Expected (\(test.type.rawValue))(\(testValue)).isBetween to be true for Float(9) - Float(11)")
        XCTAssertTrue(test.isBetween(min: Double(9), max: Double(11)), "Expected (\(test.type.rawValue))(\(testValue)).isBetween to be true for Doule(9) - Double(11)")
        XCTAssertTrue(test.isBetween(min: String(9), max: String(11.0)), "Expected (\(test.type.rawValue))(\(testValue)).isBetween to be true for String(9) - String(11)")
        XCTAssertFalse(test.isBetween(min: false, max: true), "Expected (\(test.type.rawValue))(\(testValue)).isBetween to be false for 'false' - 'true'")
        XCTAssertTrue(test.isBetween(min: Float(10.00), max: Float(11.0)), "Expected (\(test.type.rawValue))(\(testValue)).isBetween to be true for Float(10.00) - Float(11)")
        XCTAssertTrue(test.isBetween(min: Double(10.00), max: Double(11.0)), "Expected (\(test.type.rawValue))(\(testValue)).isBetween to be true for Double(10.00) - Double(11)")
        XCTAssertTrue(test.isBetween(min: String(10.00), max: String(11.0)), "Expected (\(test.type.rawValue))(\(testValue)).isBetween to be true for String(10.00) - String(11)")
        XCTAssertTrue(test.isGreaterThan(test: Int(9)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThan to be true for Int(9)")
        XCTAssertTrue(test.isGreaterThan(test: Float(9)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThan to be true for Float(9)")
        XCTAssertTrue(test.isGreaterThan(test: Double(9)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThan to be true for Double(9)")
        XCTAssertTrue(test.isGreaterThan(test: String(9)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThan to be true for String(9)")
        XCTAssertFalse(test.isGreaterThan(test: Float(10.00)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThan to be false for Float(10.00)")
        XCTAssertFalse(test.isGreaterThan(test: Double(10.00)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThan to be false for Double(10.00)")
        XCTAssertFalse(test.isGreaterThan(test: String(10.00)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThan to be false for String(10.00)")
        XCTAssertFalse(test.isGreaterThan(test: true), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThan to be false for 'true'")
        XCTAssertFalse(test.isGreaterThan(test: false), "xpected (\(test.type.rawValue))(\(testValue)).isGreaterThan to be false for 'false'")
        XCTAssertTrue(test.isGreaterThanOrEqualTo(test: Int(9)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThanOrEqualTo to be true for Int(9)")
        XCTAssertTrue(test.isGreaterThanOrEqualTo(test: Float(9)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThanOrEqualTo to be true for Float(9)")
        XCTAssertTrue(test.isGreaterThanOrEqualTo(test: Double(9)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThanOrEqualTo to be true for Double(9)")
        XCTAssertTrue(test.isGreaterThanOrEqualTo(test: String(9)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThanOrEqualTo to be true for String(9)")
        XCTAssertTrue(test.isGreaterThanOrEqualTo(test: Float(10.00)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThanOrEqualTo to be true for Float(10.00)")
        XCTAssertTrue(test.isGreaterThanOrEqualTo(test: Double(10.00)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThanOrEqualTo to be true for Double(10.00)")
        XCTAssertTrue(test.isGreaterThanOrEqualTo(test: String(10.00)), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThanOrEqualTo to be true for String(10.00)")
        XCTAssertFalse(test.isGreaterThanOrEqualTo(test: true), "Expected (\(test.type.rawValue))(\(testValue)).isGreaterThanOrEqualTo to be false for 'true'")
        XCTAssertFalse(test.isGreaterThanOrEqualTo(test: false), "xpected (\(test.type.rawValue))(\(testValue)).isGreaterThanOrEqualTo to be false for 'false'")
        XCTAssertFalse(test.isLessThan(test: Int(9)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThan to be false for Int(9)")
        XCTAssertTrue(test.isLessThan(test: Float(11)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThan to be true for Float(11)")
        XCTAssertTrue(test.isLessThan(test: Double(11)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThan to be true for Double(11)")
        XCTAssertTrue(test.isLessThan(test: String(11)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThan to be true for String(11)")
        XCTAssertFalse(test.isLessThan(test: Float(10.00)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThan to be false for Float(10.00)")
        XCTAssertFalse(test.isLessThan(test: Double(10.00)), "Expected N(\(test.type.rawValue))(\(testValue)).isLessThan to be false for Double(10.00)")
        XCTAssertFalse(test.isLessThan(test: String(10.00)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThan to be false for String(10.00)")
        XCTAssertFalse(test.isLessThan(test: true), "Expected (\(test.type.rawValue))(\(testValue)).isLessThan to be false for 'true'")
        XCTAssertFalse(test.isLessThan(test: false), "xpected (\(test.type.rawValue))(\(testValue)).isLessThan to be false for 'false'")
        XCTAssertFalse(test.isLessThanOrEqualTo(test: Int(9)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThanOrEqualTo to be false for Int(9)")
        XCTAssertTrue(test.isLessThanOrEqualTo(test: Float(11)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThanOrEqualTo to be true for Float(11)")
        XCTAssertTrue(test.isLessThanOrEqualTo(test: Double(11)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThanOrEqualTo to be true for Double(11)")
        XCTAssertTrue(test.isLessThanOrEqualTo(test: String(11)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThanOrEqualTo to be false for Float(10.95)")
        XCTAssertTrue(test.isLessThanOrEqualTo(test: Double(10.00)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThanOrEqualTo to be true for Double(10.00)")
        XCTAssertTrue(test.isLessThanOrEqualTo(test: String(10.00)), "Expected (\(test.type.rawValue))(\(testValue)).isLessThanOrEqualTo to be true for String(10.00)")
        XCTAssertFalse(test.isLessThanOrEqualTo(test: true), "Expected (\(test.type.rawValue))(\(testValue)).isLessThanOrEqualTo to be false for 'true'")
        XCTAssertFalse(test.isLessThanOrEqualTo(test: false), "xpected (\(test.type.rawValue))(\(testValue)).isLessThanOrEqualTo to be false for 'false'")
    }
    
}
