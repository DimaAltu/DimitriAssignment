//
//  AppTableViewCell.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 06.11.23.
//

import UIKit

open class AppTableViewCell: UITableViewCell, AppCellRepresentable {
    
    open var viewModel: AppCellViewModel?
    
    open class var identifier: Identifierable {
        return "unknown"
    }
}

