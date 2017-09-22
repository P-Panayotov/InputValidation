//
//  InputValue.swift
//  InputValidation
//
//  Created by Panayot Panayotov on 22/09/2017.
//  Copyright © 2017 Panayot Panayotov. All rights reserved.
//

import Foundation

public enum ValueType: String {
    case string, float, int, double, number, bool
}

public protocol InputValue: CustomStringConvertible {
    
    var type: ValueType { get }
    
    var isInt: Bool { get }
    var isFloat: Bool { get }
    var isDouble: Bool { get }
    var isString: Bool { get }
    var isBool: Bool { get }
    var isNumber: Bool { get }
    var isEmpty: Bool { get }
    
    var toInt: Int? { get }
    var toFloat: Float? { get }
    var toDouble: Double? { get }
    var toBool: Bool? { get }
    var toString: String { get }
    
    func isBetween<T: InputValue>(min: T, max: T) -> Bool
    func isLessThan<T: InputValue>(test: T) -> Bool
    func isLessThanOrEqualTo<T: InputValue>(test: T) -> Bool
    func isGreaterThan<T: InputValue>(test: T) -> Bool
    func isGreaterThanOrEqualTo<T: InputValue>(test: T) -> Bool
    
    func matches(regex: String) -> Bool
}

public extension InputValue {
    
    public var isFloat: Bool { return self.type == .float }
    public var isBool: Bool { return self.type == .bool }
    public var isDouble: Bool { return self.type == .double }
    public var isNumber: Bool { return self.type == .number }
    public var isInt: Bool { return self.type == .int }
    public var isString: Bool { return self.type == .string }
    public var toInt: Int? { return NumberFormatter().number(from: self.description)?.intValue }
    public var toFloat: Float? { return NumberFormatter().number(from: self.description)?.floatValue }
    public var toDouble: Double? { return NumberFormatter().number(from: self.description)?.doubleValue }
    public var toBool: Bool? { return nil }
    public var toString: String { return self.description }
    public var isEmpty: Bool { return self.description.replacingOccurrences(of: " ", with: "").characters.count == 0 }
    
    public func isBetween<T: InputValue, X: InputValue>(min: T, max: X) -> Bool {
        guard let thisFloat = self.toFloat,
            let minFloat = min.toFloat,
            let maxFloat = max.toFloat,
            self.type != .bool,
            min.type != .bool,
            max.type != .bool else {
                return false
        }
        return minFloat ... maxFloat ~= thisFloat
    }
    
    public func isLessThan<T: InputValue>(test: T) -> Bool {
        guard let thisFloat = self.toFloat,
            let testFloat = test.toFloat,
            self.type != .string,
            self.type != .bool,
            test.type != .bool else {
                return false
        }
        return thisFloat < testFloat
    }
    
    public func isLessThanOrEqualTo<T: InputValue>(test: T) -> Bool {
        guard let thisFloat = self.toFloat,
            let testFloat = test.toFloat,
            self.type != .string,
            self.type != .bool,
            test.type != .bool else {
                return false
        }
        return thisFloat <= testFloat
    }
    
    public func isGreaterThan<T: InputValue>(test: T) -> Bool {
        guard let thisFloat = self.toFloat,
            let testFloat = test.toFloat,
            self.type != .string,
            self.type != .bool,
            test.type != .bool else {
                return false
        }
        return thisFloat > testFloat
    }
    
    public func isGreaterThanOrEqualTo<T: InputValue>(test: T) -> Bool {
        guard let thisFloat = self.toFloat,
            let testFloat = test.toFloat,
            self.type != .string,
            self.type != .bool,
            test.type != .bool else {
                return false
        }
        return thisFloat >= testFloat
    }
    
    public func matches(regex: String) -> Bool {
        return self.description.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

extension String: InputValue {
    public var type: ValueType { return .string }
}

extension NSNumber: InputValue {
    public var type: ValueType { return .number }
}

extension Float: InputValue {
    public var type: ValueType { return .float }
}

extension Int: InputValue {
    public var type: ValueType { return .int }
}

extension Double: InputValue {
    public var type: ValueType { return .double }
}

extension Bool: InputValue {
    public var type: ValueType { return .bool }
    public var toBool: Bool? { return Bool(self.description) }
}
