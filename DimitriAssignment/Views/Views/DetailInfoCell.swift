//
//  DetailInfoCell.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 09.11.23.
//

import UIKit

class DetailInfoCell: AppTableViewCell {
    
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let value: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override var viewModel: AppCellViewModel? {
        didSet {
            super.viewModel = viewModel
            guard let viewModel = viewModel as? DetailInfoCellViewModel else { fatalError() }
            title.text = viewModel.title
            value.text = viewModel.value
            self.selectionStyle = .none
        }
    }
    
    override class var identifier: Identifierable {
        "DetailInfoCellViewModel"
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
        setupUI()
    }
    
    private func setupSubviews() {
        self.contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(title)
        mainStackView.addArrangedSubview(value)
    }
    
    private func setupUI() {
        mainStackView.layer.cornerRadius = 16
        mainStackView.backgroundColor = .gray.withAlphaComponent(0.5)
    }
    
    private func setupConstraints() {
        mainStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        mainStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        mainStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }
}

struct DetailInfoCellViewModel: AppCellViewModel {
    var identifier: String = "DetailInfoCellViewModel"
    let title: String
    let value: String
}

