# Ligh Swift library for user input validation

[![Build Status](https://travis-ci.org/PanPanayotov/InputValidation.svg?branch=master)](https://travis-ci.org/PanPanayotov/InputValidation)
[![Platform](https://img.shields.io/badge/platform-iOS,%20macOS,%20tvOS-green.svg)]()
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Requirements
- Xcode >= 8.*
- Swift >= 3.*

By default input validation can be used on all of the following value types:
* String
* Float
* Double
* Int
* Bool

## What is InputValidation
InputValidation is a very light weight library written in Swift, and aimed to help developers with the boring task of validating some user input. My goal was to make this as generic as possible without complicating it, and at the same time to be able to perform any validation on any value type. For example you can evaluate regex match on `Int` `Float` `Double` `Bool` and `String`, or to convert InputValues from one type to another.

## Value type from the user input

``` swift

let values = [12, 45.245, "hello", "", NSNumber(value: true), NSNumber(value: 12), NSNumber(value: 65.28), false, true]

for value:InputValue in values {
    if !value.isEmpty {
        switch value.type {
          case .string:
            print("String")
          case .int:
            print("Int")
          case .float:
            print("Float")
          case .double:
            print("Double")
          case .number:
            print("Number")
          case .bool:
            print("Boolean")
        }
    } else {
        print("value:'\(value)' of type \(value.type.rawValue) is empty")
    }
}


```

## Convert user input to specific value type

``` swift

let userInput = "1"

if let stringValue = userInput.toString {
  print("String value: \(stringValue)")
}

if let intValue = userInput.toInt {
  print("Int value: \(intValue)")
}

if let floatValue = userInput.toFloat {
  print("Float value: \(floatValue)")
}

if let doubleValue = userInput.toDouble {
  print("Double value: \(doubleValue)")
}

if let boolValue = userInput.toBool {
  print("Boolean value: \(boolValue)")
}


```

## Comparison operations

``` Swift

let userInput = 10

/*
  You can use either String, Int, Double or Float 
  as parameter to run the comparison. 
  See in examples below
*/

userInput.isBetween(9,11) // returns true

userInput.isLessThan("11") // returns true

userInput.isLessThanOrEqualTo(10.0) // returns true

userInput.isGreaterThan(9.1235768435214685654657854) // returns true

userInput.isGreaterThanOrEqualTo(9) // returns true

```

## Evaluate regular expressions
``` swift
let values = [12, 45.245, "hello", "", NSNumber(value: true), NSNumber(value: 12), NSNumber(value: 65.28), false, true]

for value:InputValue in values {
    if !value.isEmpty {
        let regex = "^[a-z]+$"
        if value.matches(regex: regex) {
            print("value:'\(value)' of type \(value.type.rawValue) is matching '\(regex)'")
        } else {
            print("value:'\(value)' of type \(value.type.rawValue) did not match '\(regex)'")
        }
    } else {
        print("value:'\(value)' of type \(value.type.rawValue) is empty")
    }
}
```

## Installing with carthage

Add InputValidation into your Cartfile
```
github "PanPanayotov/InputValidation"
```
Build 
``` bash
carthage update
```
