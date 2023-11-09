//
//  SpacerCell.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 09.11.23.
//

import UIKit

class SpacerCell: AppTableViewCell {
    
    private var heightConstraint: NSLayoutConstraint!
    
    override var viewModel: AppCellViewModel? {
        didSet {
            super.viewModel = viewModel
            guard let viewModel = viewModel as? SpacerCellViewModel else { fatalError() }
            heightConstraint.constant = viewModel.spacing
            contentView.backgroundColor = viewModel.backgroundColor
            self.selectionStyle = .none
        }
    }
    
    override class var identifier: Identifierable {
        "SpacerCellViewModel"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 16)
        heightConstraint.isActive = true
    }
}

struct SpacerCellViewModel: AppCellViewModel {
    var identifier: String = "SpacerCellViewModel"
    let spacing: CGFloat
    let backgroundColor: UIColor
}


