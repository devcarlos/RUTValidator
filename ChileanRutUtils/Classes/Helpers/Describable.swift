//
//  Describable.swift
//  ChileanRutUtilsTest
//
//  Created by Algunos Wones de Latam on 9/23/19.
//  Copyright © 2019 Algunos Wones de Latam. All rights reserved.
//

import Foundation

public protocol Describable: AnyObject {
    static var identifier: String { get }
}

public extension Describable {
    /// Do you want an identifier, before apple adds it.
    static var identifier: String { String(describing: self) }
}
