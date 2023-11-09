//
//  UITableView+Extensions.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 06.11.23.
//

import UIKit

extension UITableView: UITableViewDequeuable {
    public func dequeueReusable(viewModel: AppCellViewModel, for indexPath: IndexPath) -> AppTableViewCell {
        return dequeueReusableCell(withIdentifier: viewModel.identifier, for: indexPath) as! AppTableViewCell
    }
    
    public func dequeueReusable(viewModel: AppCellViewModel) -> AppTableViewCell {
        return dequeueReusableCell(withIdentifier: viewModel.identifier) as! AppTableViewCell
    }
    
    public func dequeueReusable<T: AppTableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifierValue, for: indexPath) as! T
    }
    
    public func dequeueReusable<T: AppTableViewCell>(cell: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: T.identifierValue) as? T
    }
}

extension UITableView {
    public func register(types: AppTableViewCell.Type...) {
        register(types: types.map { $0 })
    }
    
    public func register(types: [AppTableViewCell.Type]) {
        types.forEach {
            register($0.self, forCellReuseIdentifier: $0.identifierValue)
        }
    }
}

