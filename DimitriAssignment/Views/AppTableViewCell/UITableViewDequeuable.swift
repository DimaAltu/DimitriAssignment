//
//  UITableViewDequeuable.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 06.11.23.
//

import UIKit

public protocol UITableViewDequeuable {
    func dequeueReusable(viewModel: AppCellViewModel, for indexPath: IndexPath) -> AppTableViewCell
    func dequeueReusable<T: AppTableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T
    func dequeueReusable<T: AppTableViewCell>(cell: T.Type) -> T?
}
