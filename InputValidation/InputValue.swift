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

    /// Holds the ValueType of the object implementing InputValue protocol
    var type: ValueType { get }

    /// True if the object implementing InputValue protocol is Integer
    var isInt: Bool { get }
    /// True if the object implementing InputValue protocol is Float
    var isFloat: Bool { get }
    /// True if the object implementing InputValue protocol is Double
    var isDouble: Bool { get }
    /// True if the object implementing InputValue protocol is String
    var isString: Bool { get }
    /// True if the object implementing InputValue protocol is Bool
    var isBool: Bool { get }
    /// True if the object implementing InputValue protocol is Number
    var isNumber: Bool { get }
    /// True if the object implementing InputValue protocol is Empty (ignores spaces)
    var isEmpty: Bool { get }

    /// Integer value of the object implementing InputValue protocol
    var toInt: Int? { get }
    /// Float value of the object implementing InputValue protocol
    var toFloat: Float? { get }
    /// Double value of the object implementing InputValue protocol
    var toDouble: Double? { get }
    /// Boolean value of the object implementing InputValue protocol
    var toBool: Bool? { get }
    /// String value of the object implementing InputValue protocol
    var toString: String { get }

    /// Logical comparison between this and two other objects
    /// also implementing InputValue protocol
    ///
    /// - Parameters:
    ///   - min: Minimum input value
    ///   - max: Maximum input value
    /// - Returns: True if this InputValue is between min and max values. Example 'result = this >= min && <= max'
    func isBetween<T: InputValue>(min: T, max: T) -> Bool

    /// Logical comparison to check if this InputValue is
    /// less than the reference value passed as an argument
    ///
    /// - Parameter test: Reference value used for comparison
    /// - Returns: True if this InputValue is less than the reference. Example 'result = this < reference'
    func isLessThan<T: InputValue>(test: T) -> Bool

    /// Logical comparison to check if this InputValue is
    /// less than or equal to the reference value passed as an argument
    ///
    /// - Parameter test: Reference value used for comparison
    /// - Returns: True if this InputValue is less than or equal to the reference. Example 'result = this <= reference'
    func isLessThanOrEqualTo<T: InputValue>(test: T) -> Bool

    /// Logical comparison to check if this InputValue is
    /// greater than the reference value passed as an argument
    ///
    /// - Parameter test: Reference value used for comparison
    /// - Returns: True if this InputValue is greater than the reference. Example 'result = this > reference'
    func isGreaterThan<T: InputValue>(test: T) -> Bool

    /// Logical comparison to check if this InputValue is
    /// greater than or equal to the reference value passed as an argument
    ///
    /// - Parameter test: Reference value used for comparison
    /// - Returns: True if this InputValue is greater than or equal to the reference. Example 'result = this >= reference'
    func isGreaterThanOrEqualTo<T: InputValue>(test: T) -> Bool

    /// Performs a RegEx evaluation on the current InputValue
    ///
    /// - Parameter regex: RegEx value. Example '^[\d]+$' will match only numbers
    /// - Returns: True if RexEx evaluation was successfull
    func matches(regex: String) -> Bool
}

extension InputValue {

    public var isFloat: Bool { return type == .float }
    public var isBool: Bool { return type == .bool }
    public var isDouble: Bool { return type == .double }
    public var isNumber: Bool { return type == .number }
    public var isInt: Bool { return type == .int }
    public var isString: Bool { return type == .string }
    public var toInt: Int? { return NumberFormatter().number(from: toString)?.intValue }
    public var toFloat: Float? { return NumberFormatter().number(from: toString)?.floatValue }
    public var toDouble: Double? { return NumberFormatter().number(from: toString)?.doubleValue }
    public var toBool: Bool? { return nil }
    public var toString: String { return String(describing: self) }
    public var isEmpty: Bool { return toString.replacingOccurrences(of: " ", with: "").count == 0 }

    public func isBetween<T: InputValue, X: InputValue>(min: T, max: X) -> Bool {
        guard let thisFloat = toFloat,
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
        guard let thisFloat = toFloat,
            let testFloat = test.toFloat,
            type != .string,
            type != .bool,
            test.type != .bool else {
                return false
        }
        return thisFloat < testFloat
    }

    public func isLessThanOrEqualTo<T: InputValue>(test: T) -> Bool {
        guard let thisFloat = toFloat,
            let testFloat = test.toFloat,
            type != .string,
            type != .bool,
            test.type != .bool else {
                return false
        }
        return thisFloat <= testFloat
    }

    public func isGreaterThan<T: InputValue>(test: T) -> Bool {
        guard let thisFloat = toFloat,
            let testFloat = test.toFloat,
            type != .string,
            type != .bool,
            test.type != .bool else {
                return false
        }
        return thisFloat > testFloat
    }

    public func isGreaterThanOrEqualTo<T: InputValue>(test: T) -> Bool {
        guard let thisFloat = toFloat,
            let testFloat = test.toFloat,
            type != .string,
            type != .bool,
            test.type != .bool else {
                return false
        }
        return thisFloat >= testFloat
    }

    public func matches(regex: String) -> Bool {
        if type == .bool { return false }
        return toString.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
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
    public var toBool: Bool? { return self }
}
