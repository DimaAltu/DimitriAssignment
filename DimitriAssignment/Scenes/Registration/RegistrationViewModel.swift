//
//  RegistrationViewModel.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 07.11.23.
//

import Foundation

class RegistrationViewModel {
    var email: GenericBox<String>
    var password: GenericBox<String>
    var age: GenericBox<Int?>
    var rows: GenericBox<[AppCellViewModel]>
    var router: RegistrationRouter
    
    let emailValidator: EmailValidator
    let passwordValidator: PasswordValidator
    let ageValidator: AgeValidator
    
    let registerUseCase: RegistrationUseCase
    
    var emailErrorModel: Input.ErrorTextViewModel?
    var passwordErrorModel: Input.ErrorTextViewModel?
    var ageErrorModel: Input.ErrorTextViewModel?
    
    var isEmailValid: Bool {
        emailValidator.isEmailValid(email: email.value)
    }
    
    var isPasswordValid: Bool {
        passwordValidator.validatePassword(password: password.value)
    }
    
    var isAgeValid: Bool {
        guard let age = age.value else { return false }
        return ageValidator.validateAge(age: age)
    }
    
    init(email: String,
         password: String,
         age: Int?,
         router: RegistrationRouter,
         emailValidator: EmailValidator,
         passwordValidator: PasswordValidator,
         ageValidator: AgeValidator,
         registerUseCase: RegistrationUseCase) {
        self.email = GenericBox(email)
        self.password = GenericBox(password)
        self.age = GenericBox(age)
        self.rows = GenericBox([])
        self.router = router
        self.emailValidator = emailValidator
        self.passwordValidator = passwordValidator
        self.ageValidator = ageValidator
        self.registerUseCase = registerUseCase
        configureRows()
    }
    
    private func configureRows() {
        var rowItems: [AppCellViewModel] = []
        rowItems.append(InputCellViewModel(inputModel: Input.ViewModel(
            inputText: email.value,
            errorTextModel: emailErrorModel,
            placeholder: "Email",
            forPassword: false,
            didChangedText: { [weak self] _, string in
                guard let self else { return }
                email.value = string
                emailErrorModel = isEmailValid ? nil : .emailNotValid
            }))
        )
        
        rowItems.append(InputCellViewModel(inputModel: Input.ViewModel(
            inputText: password.value,
            errorTextModel: passwordErrorModel,
            placeholder: "Password",
            forPassword: true,
            didChangedText: { [weak self] _, string in
                guard let self else { return }
                password.value = string
                passwordErrorModel = isPasswordValid ? nil : .passwordInvalidCount
            }))
        )
        
        rowItems.append(InputCellViewModel(inputModel: Input.ViewModel(
            inputText: age.value?.description,
            errorTextModel: ageErrorModel,
            placeholder: "Age",
            forPassword: false,
            keyboardType: .numberPad,
            didChangedText: { [weak self] _, string in
                guard let ageInt = Int(string) else { return }
                self?.age.value = ageInt
            }))
        )
        rows.value = rowItems
    }
    
    func didTappedRegister() {
        validate()
        configureRows()
    }
    
    private func validate() {
        if !isEmailValid {
            emailErrorModel = .emailNotValid
        }
        if !isPasswordValid {
            passwordErrorModel = .passwordInvalidCount
        }
        if !isAgeValid {
            ageErrorModel = .invalidAge
        }
        if isEmailValid, isPasswordValid, isAgeValid {
            sendRegisterRequest()
        }
    }
    
    private func sendRegisterRequest() {
        Task.init {
            do {
                let isRegistered = try await registerUseCase.registerUser(
                    requestModel: RegisterRequest(
                        email: email.value,
                        password: password.value,
                        age: age.value ?? 0
                    )
                )
                DispatchQueue.main.async {
                    if isRegistered {
                        self.router.openDashboardPage()
                    }
                }
            } catch { print(error) }
        }
    }
    
}
