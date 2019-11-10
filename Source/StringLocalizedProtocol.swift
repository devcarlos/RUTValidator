//
//  StringLocalizedProtocol.swift
//  ChileanRutUtilsTest
//
//  Created by Algunos Wones de Latam on 10/9/19.
//

//swiftlint:disable missing_docs
public protocol StringLocalizedProtocol: RawRepresentable {
    var localized: String { get }

    func localized(with args: CVarArg...) -> String
}

public extension StringLocalizedProtocol where RawValue == String {
    var localized: String { self.rawValue.localized }

    func localized(with args: CVarArg...) -> String {
        String(format: self.rawValue.localized, arguments: args)
    }
}

public extension String {
    var localized: String { NSLocalizedString(self, comment: "") }
}
