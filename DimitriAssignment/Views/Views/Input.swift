//
//  Input.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 03.11.23.
//

import UIKit

extension Input {
    typealias InputDidChangedText = ((Input, String) -> ())
}

class Input: UIView {
    
    private var editableTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    private var errorText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    var didChangedText: InputDidChangedText?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
        setupInputFields()
        setupUI()
    }
    
    private func setupSubviews() {
        self.addSubview(containerStack)
        containerStack.addArrangedSubview(editableTextField)
        containerStack.addArrangedSubview(errorText)
    }
    
    private func setupConstraints() {
        editableTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
        containerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupUI() {
        editableTextField.backgroundColor = .gray.withAlphaComponent(0.2)
        editableTextField.layer.cornerRadius = 16
        let paddingView = UIView(frame: CGRectMake(0, 0, 10, editableTextField.frame.height))
        editableTextField.leftView = paddingView
        editableTextField.leftViewMode = UITextField.ViewMode.always
        
    }
    
    private func setupInputFields() {
        editableTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
        didChangedText?(self, editableTextField.text ?? "")
    }
    
    func configure(model: ViewModel) {
        editableTextField.text = model.inputText
        editableTextField.keyboardType = model.keyboardType
        self.didChangedText = model.didChangedText
        editableTextField.placeholder = model.placeholder
        editableTextField.isSecureTextEntry = model.forPassword
        configureErrorText(model: model.errorTextModel)
    }
    
    func configureErrorText(model: ErrorTextViewModel?) {
        errorText.isHidden = model == nil
        errorText.text = model?.errorText
        errorText.textColor = model?.errorTextColor
    }
    
}

extension Input {
    struct ViewModel {
        let inputText: String?
        let errorTextModel: ErrorTextViewModel?
        let placeholder: String?
        let forPassword: Bool
        let didChangedText: InputDidChangedText?
        let keyboardType: UIKeyboardType
        
        init(inputText: String?, 
             errorTextModel: ErrorTextViewModel?,
             placeholder: String?,
             forPassword: Bool,
             keyboardType: UIKeyboardType = .default,
             didChangedText: InputDidChangedText?) {
            self.inputText = inputText
            self.errorTextModel = errorTextModel
            self.placeholder = placeholder
            self.forPassword = forPassword
            self.didChangedText = didChangedText
            self.keyboardType = keyboardType
        }
    }
    
    struct ErrorTextViewModel {
        var errorText: String?
        var errorTextColor: UIColor?
    }
}
