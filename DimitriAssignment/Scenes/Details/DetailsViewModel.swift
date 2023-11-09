//
//  DetailsViewModel.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 07.11.23.
//

import Foundation

class DetailsViewModel {
    
    let imageModel: ImageModel
    
    var sections: GenericBox<[[AppCellViewModel]]>
    
    init(imageModel: ImageModel) {
        self.imageModel = imageModel
        self.sections = GenericBox([])
        configureRows()
    }
    
    func configureRows() {
        var firstSection: [AppCellViewModel] = []
        
        firstSection.append(HomeImageCellViewModel(imageUrl: URL(string: imageModel.webformatURL), title: nil))
                
        let imageSize = DetailInfoCellViewModel(title: "ფოტოს ზომა", value: "\(imageModel.imageSize) byte")
        firstSection.append(imageSize)
        
        let typeValue = imageModel.webformatURL.split(separator: ".").last
        let imageType = DetailInfoCellViewModel(title: "ფოტოს ტიპი", value: ".\(typeValue ?? "")")
        firstSection.append(imageType)
        
        let imageTags = DetailInfoCellViewModel(title: "ფოტოს თეგები", value: imageModel.tags)
        firstSection.append(imageTags)
        
        let spacer = SpacerCellViewModel(spacing: 32, backgroundColor: .clear)
        firstSection.append(spacer)
        
        var secondSection: [AppCellViewModel] = []
        
        let imageAuthorInfo = DetailInfoCellViewModel(title: "ფოტოს ავტორის ინფორმაცია", value: imageModel.user)
        secondSection.append(imageAuthorInfo)
        
        let viewsCount = DetailInfoCellViewModel(title: "ფოტოს ნახვების რაოდენობა", value: imageModel.views.description)
        secondSection.append(viewsCount)
        
        let likesCount = DetailInfoCellViewModel(title: "ლაიქების რაოდენობა", value: imageModel.likes.description)
        secondSection.append(likesCount)
        
        let commentsCount = DetailInfoCellViewModel(title: "კომენტარების რაოდენობა", value: imageModel.comments.description)
        secondSection.append(commentsCount)
        
        let favoritesCount = DetailInfoCellViewModel(title: "ფავორიტებში დამატების რაოდენობა", value: imageModel.collections.description)
        secondSection.append(favoritesCount)
        
        let downloadCount = DetailInfoCellViewModel(title: "გადმოწერების რაოდენობა", value: imageModel.downloads.description)
        secondSection.append(downloadCount)
        
        sections.value = [firstSection, secondSection]
    }
    
}
