//
//  IdentifierAble.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 06.11.23.
//

public protocol Identifierable {
    var identifier: String { get }
}

extension String: Identifierable {
    public var identifier: String {
        return self
    }
}
