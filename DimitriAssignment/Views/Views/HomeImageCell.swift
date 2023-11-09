//
//  HomeImageCell.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 08.11.23.
//

import UIKit
import SDWebImage

class HomeImageCell: AppTableViewCell {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .gray
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        return label
    }()
    
    override var viewModel: AppCellViewModel? {
        didSet {
            super.viewModel = viewModel
            guard let viewModel = viewModel as? HomeImageCellViewModel else { fatalError() }
            image.sd_setImage(with: viewModel.imageUrl)
            title.isHidden = viewModel.title == nil
            title.text = viewModel.title
            self.selectionStyle = .none
        }
    }
    
    override class var identifier: Identifierable {
        "HomeImageCellViewModel"
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
        self.contentView.addSubview(image)
        self.contentView.addSubview(title)
    }
    
    private func setupConstraints() {
        image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        image.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        image.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        title.trailingAnchor.constraint(equalTo: image.trailingAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: image.bottomAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

struct HomeImageCellViewModel: AppCellViewModel {
    var identifier: String = "HomeImageCellViewModel"
    let imageUrl: URL?
    let title: String?
}
