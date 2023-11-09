//
//  AppCellRepresentable.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 06.11.23.
//

import UIKit

public protocol AppCellRepresentable: AnyObject {
    static var identifier: Identifierable { get }
}

public extension AppCellRepresentable {
    static var identifierValue: String {
        return identifier.identifier
    }
}

