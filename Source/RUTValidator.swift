//
//  RUTValidator.swift
//  ChileanRutUtils
//
//  Created by Algunos Wones de Latam on 10/2/19.
//  Copyright © 2019 Algunos Wones de Latam. All rights reserved.
//

import Foundation

//swiftlint:disable identifier_name
/// The most beautiful chilean rut validator
public enum RUTValidator {

    //This enum contains the chilean character map
    //Please dont rename the keys, it is magical, ask the unicorns.
    private enum RutVerificationDigit: Int, CaseIterable, Equatable {
        case ´1´ = 1
        case ´2´ = 2
        case ´3´ = 3
        case ´4´ = 4
        case ´5´ = 5
        case ´6´ = 6
        case ´7´ = 7
        case ´8´ = 8
        case ´9´ = 9
        case ´k´ = 10
        case ´0´ = 11

        //This case is only used on utility method create RutVerificationDigit
        case none = -1

        /// This computed variable, returns the keyname of the enum as a Character
        var character: Character {
            let enumKeyName = "\(self)"
            let index = enumKeyName.index(enumKeyName.startIndex, offsetBy: 1)
            let digitKeyName = enumKeyName[index]
            return digitKeyName
        }

        static func == (lhs: RutVerificationDigit, rhs: RutVerificationDigit) -> Bool {
            return lhs.character == rhs.character
        }
    }

    /// This var contains allowed chars in your clean rut
    private static let allowedRutCharacters = #"[^[0-9],^k^K]"#
    private static let patternNumbers = #"^[0-9]+$"#

    private static let regexNumbers = try? NSRegularExpression(
        pattern: patternNumbers,
        options: .allowCommentsAndWhitespace
    )

    /// This var contains the chilean full formatted pattern
    private static let patternFormatted = #"""
    ^[0-9]{1,2} # chequea si hay 2 o 3 numeros iniciales
    (\.[0-9]{3})* # chequea los bloques .XXX
    \- # signo de division de digito identificador
    [0-9,kK] # digito identificador
    """#

    /// Regex for the formatted pattern
    private static let regexFormatted = try? NSRegularExpression(
        pattern: patternFormatted,
        options: .allowCommentsAndWhitespace
    )

    /// This var contains the chilean clean rut pattern
    private static let patternRaw = #"""
    ^[0-9] # un primer digito
    [0-9]* # varios digitos
    [0-9,kK]$ # puede terminar en k como digito verificador
    """#

    /// Regex for the clean pattern
    private static let regexRaw = try? NSRegularExpression(
        pattern: patternRaw,
        options: .allowCommentsAndWhitespace
    )

    /// This method will create a RutVerificationDigit between  1-11, if out of bounds, returns .none
    ///
    /// - Parameter rawValue: Enter the int number of the digit verificator, between 1-11 { 10 for k, 11 for 0 }
    private static func createRutVerificationDigit(rawInt: Int) -> RutVerificationDigit {
        if let rutVerificationDigit = RutVerificationDigit(rawValue: rawInt),
            rutVerificationDigit != .none {
            return rutVerificationDigit
        }

        return .none
    }

    /// This method will create a RutVerificationDigit using Character: 0-9 and k
    ///
    /// - Parameter rawChar: characters from 0-9, and k
    private static func createRutVerificationDigit(rawChar: Character) -> RutVerificationDigit {
        let digits = RutVerificationDigit.allCases.filter { $0.character == rawChar }

        guard let digit = digits.first else {
            return .none
        }

        return digit
    }

    /// This method wil check first if the rut is formatted corrected, and secondly if its a valid chilean rut number
    ///  Returns a tuple group (bool, and correct format string)
    ///
    /// - Parameter rut: chilean rut string, can be formatted with hypen and dots, or a string.
    public static func validateRUT(_ rut: String) -> (isValid: Bool, formatted: String) {

        guard
            let regexFormatted = regexFormatted, let regexRaw = regexRaw,
            regexFormatted.matches(rut) || regexRaw.matches(rut) else {
                return (false, rut)
        }

        let cleanedRut = cleanRut(rut)
        return (validRut(cleanedRut), formatRut(cleanedRut))
    }

    /// This method returns a correct formated chilean rut string
    ///
    /// - Parameter rut: chilean rut string, can be formatted with hypen and dots, or a string.
    public static func formatRut(_ rut: String) -> String {
        var cleanedRut = cleanRut(rut)

        guard rut.count > 1 else {
            return rut
        }

        //Get dv and body rut
        let verificationDigit = cleanedRut.removeLast()

        //Reverse the string
        let reversedCleanedRut = cleanedRut.reversed()

        //Group rutBody by maxLength of 3, glue it with separator, reverse it
        let formattedRutBody = String(
            reversedCleanedRut
                .groupedBy(3)
                .joined(separator: ".")
                .reversed()
        )

        //Returns formated body rut and dv.
        return "\(formattedRutBody)-\(verificationDigit)"
    }

    /// This method returns a string and removes dots and hypen from the rut,
    /// it will also remove any other foreign chracters too.
    ///
    /// - Parameter rut: chilean rut string, can be formatted with hypen and dots, or a string.
    public static func cleanRut(_ rut: String) -> String {
        return rut.replacingOccurrences(
            of: allowedRutCharacters,
            with: "",
            options: .regularExpression
        )
    }

    /// This method will check if the rut is mathematically correct.
    ///
    /// - Parameter string: chilean rut numbers only
    public static func validRut(_ rut: String) -> Bool {
        var rutBody = rut.lowercased()
        guard
            let regexFormatted = regexFormatted, let regexRaw = regexRaw,
            regexFormatted.matches(rut) || regexRaw.matches(rut) else {
                return false
        }

        //Separate rutBody and dv number
        let verificationDigitNumber = rutBody.removeLast()
        let verificationDigit = createRutVerificationDigit(rawChar: verificationDigitNumber)

        let calculatedNumber = calculateVerificationDigit(rutBody: rutBody)
        let calculatedVerificationDigit = createRutVerificationDigit(rawInt: calculatedNumber)

        return verificationDigit == calculatedVerificationDigit
    }

    /// This method will calculate the digit verifier from a rut body
    ///  Returns and Int from 0 to 11
    ///
    /// - Parameter rutBody: the chilean rut number, but without the identifier number.
    static func calculateVerificationDigit (rutBody: String) -> Int {

        guard let regex = regexNumbers, regex.matches(rutBody) else {
            // Should be a throw, but -1 returns later a RutVerificationDigit.none
            return -1
        }

        struct RutValidatorGenerator: Sequence, IteratorProtocol {
            var current = 2

            mutating func next() -> Int? {
                defer {
                    current == 7 ? (current = 2) : (current += 1)
                }

                return current
            }
        }

        let validateChar = rutBody.reversed()

        let validatorSequence = RutValidatorGenerator().prefix(validateChar.count)
        let sum = zip(validateChar, validatorSequence)
            .map { Int(String($0))! * $1 } //swiftlint:disable:this force_unwrapping
            .reduce(0, +)
        let digit = 11 - sum % 11

        return digit
    }

    /// This method will return the full chilean rut with generated digit verifier, it will tell:
    ///  first if its valid, second the formetted chilean rut, and its raw string.
    ///
    /// - Parameter rutBody: the chilean rut number, but without the identifier number.
    public static func getVerificationDigit(rutBody: String) -> (isValid: Bool, formatted: String, rawRut: String) {
        let cleanedRutBody = cleanRut(rutBody)
        let digit = calculateVerificationDigit(rutBody: cleanedRutBody)
        let rutDigit = createRutVerificationDigit(rawInt: digit)

        if rutDigit != .none {
            let valid = validateRUT("\(cleanedRutBody)\(rutDigit.character)")
            return (valid.isValid, valid.formatted, cleanRut(valid.formatted))
        }

        return (false, rutBody, rutBody)
    }
}

private extension NSRegularExpression {
    /// This method is a nice helper to create a range for your regular expression.
    /// - Parameter string: pattern
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

private extension ReversedCollection where Base == String {
    /// This method returns an array of grouped strings of given length
    ///
    /// - Parameter length: max length string to group
    func groupedBy(_ length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
}
