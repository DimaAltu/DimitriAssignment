//
//  InputCell.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 03.11.23.
//

import UIKit

class InputCell: AppTableViewCell {
    
    private var input: Input = {
        let input = Input()
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    override var viewModel: AppCellViewModel? {
        didSet {
            super.viewModel = viewModel
            guard let viewModel = viewModel as? InputCellViewModel else { fatalError() }
            input.configure(model: viewModel.inputModel)
            selectionStyle = .none
        }
    }
    
    override class var identifier: Identifierable {
        "InputCellViewModel"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        self.contentView.addSubview(input)
    }
    
    private func setupConstraints() {
        input.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        input.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        input.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        input.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
}

struct InputCellViewModel: AppCellViewModel {
    var identifier: String = "InputCellViewModel"
    let inputModel: Input.ViewModel
}
