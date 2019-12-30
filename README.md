# RUTValidator
> RUTValidator is a Library made in Swift to Validate and Format a Chilean RUT (Rol Unico Tributario)

[![Build Status](https://travis-ci.com/devcarlos/RUTValidator.svg?token=JeyiLqSQpjNRQyWZyBEg&branch=master)](https://travis-ci.com/devcarlos/RUTValidator)
[![Swift 5.0](https://img.shields.io/badge/swift-5.0-red.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://opensource.org/licenses/MIT)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/RUTValidator.svg)](https://img.shields.io/cocoapods/v/LFAlertController.svg)  
[![Platform](https://img.shields.io/cocoapods/p/RUTValidator.svg?style=flat)](http://cocoapods.org/pods/RUTValidator)
[![PRs Welcome](https://img.shields.io/badge/RUTValidator.svg?style=flat-square)](http://makeapullrequest.com)

RUTValidator is a Library made in Swift to Validate and Format a Chilean RUT (Rol Unico Tributario)

## Features

- [x] RUT Validator

## Requirements

- iOS 11+
- Xcode 11
- Swift 5.0

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `RUTValidator` by adding it to your `Podfile`:

```ruby
platform :ios, '11.0'
use_frameworks!
pod 'RUTValidator'
```

To get the full benefits import `RUTValidator` wherever you need it

``` swift
import RUTValidator
```
#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/RUTValidator.framework` to an iOS project.

```
github "devcarlos/RUTValidator"
```

## Code Examples

```swift
import RUTValidator
```

```swift
//Test Example validateRUT
let unformattedRut = "19"
let formattedRut = "1-9"
let validator = RUTValidator.validateRUT(unformattedRut)

XCTAssertTrue(validator.isValid)
XCTAssertEqual(validator.formatted, formattedRut)
```

```swift
//Test Example formatRut
let realFormatedRut = RUTValidator.formatRut(unformattedRut)
XCTAssertEqual(formattedRut, realFormatedRut)
```

```swift
//Test Example getVerificationDigit
let bodyRut = "9043943"
let formattedRut = "9.043.943-k"
let rawRut = "9043943k"
let validator = RUTValidator.getVerificationDigit(rutBody: bodyRut)
XCTAssertTrue(validator.isValid)
XCTAssertEqual(validator.formatted, formattedRut)
XCTAssertEqual(validator.rawRut, rawRut)
```

```swift
//Test Example calculateVerificationDigit
let bodyRut = "9043943"
let dv = Int(10)
let calculatedDV = RUTValidator.calculateVerificationDigit(rutBody: bodyRut)
XCTAssertEqual(calculatedDV, dv)
```

```swift
//Test Example cleanRUT
let unformattedRut = "20.961.605-K"
let expectedCleanRut = "20961605K"
let cleanRut = RUTValidator.cleanRut(unformattedRut)
XCTAssertEqual(cleanRut, expectedCleanRut)
```

## Contribute

We would love you for the contribution to **RUTValidator**, check the ``LICENSE`` file for more info.

## Author

* Magno Cardona aka Magno por la Chucha (acidfilez@gmail.com)
* Carlos Alcala aka Charles Xavier (Profesori) (carlos.alcala@me.com)

## License

RUTValidator is distributed under the MIT license. See ``LICENSE`` for more information.

## Meta

[![Build Status](https://travis-ci.com/devcarlos/RUTValidator.svg?token=JeyiLqSQpjNRQyWZyBEg&branch=master)](https://travis-ci.com/devcarlos/RUTValidator)
[![Swift 5.0](https://img.shields.io/badge/swift-5.0-red.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://opensource.org/licenses/MIT)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg)](https://img.shields.io/cocoapods/v/LFAlertController.svg)  
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
