//
//  LoginViewModel.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 03.11.23.
//

import Foundation

class LoginViewModel {
    
    var email: GenericBox<String>
    var password: GenericBox<String>
    var rows: GenericBox<[AppCellViewModel]>
    
    var emailErrorModel: Input.ErrorTextViewModel = .init(errorText: "", errorTextColor: nil)
    var passwordErrorModel: Input.ErrorTextViewModel = .init(errorText: "", errorTextColor: nil)
    
    var router: LoginRouter
    
    let emailValidator: EmailValidator
    let passwordValidator: PasswordValidator
    
    let loginUseCase: LoginUseCase
    
    init(router: LoginRouter, 
         email: String,
         password: String,
         emailValidator: EmailValidator,
         passwordValidator: PasswordValidator,
         loginUseCase: LoginUseCase) {
        self.email = GenericBox("d.altunashvili@gmail.com")
        self.password = GenericBox("123456")
        self.router = router
        self.rows = GenericBox([])
        self.emailValidator = emailValidator
        self.passwordValidator = passwordValidator
        self.loginUseCase = loginUseCase
        configureRows()
    }
    
    private func configureRows() {
        var rowItems: [AppCellViewModel] = []
        rowItems.append(InputCellViewModel(inputModel: Input.ViewModel(
            inputText: email.value,
            errorTextModel: emailErrorModel,
            placeholder: "Email",
            forPassword: false,
            didChangedText: { [weak self] _, email in
                self?.email.value = email
            }))
        )
        
        rowItems.append(InputCellViewModel(inputModel: Input.ViewModel(
            inputText: password.value,
            errorTextModel: passwordErrorModel,
            placeholder: "Password",
            forPassword: true,
            didChangedText: { [weak self] _, string in
                self?.password.value = string
            }))
        )
        rows.value = rowItems
    }
    
    func didTappedLogin() {
        validate()
        configureRows()
    }
    
    func didTappedRegister() {
        openRegister()
    }
    
    private func validate() {
        guard emailValidator.isEmailValid(email: email.value) else {
            emailErrorModel = .emailNotValid
            return
        }
        guard passwordValidator.validatePassword(password: password.value) else {
            passwordErrorModel = .passwordInvalidCount
            return
        }
        checkIfUserExistsInDatabase()
    }
    
    private func checkIfUserExistsInDatabase() {
        guard let pass = registeredUsers[email.value] else {
            emailErrorModel = .emailNotExists
            return
        }
        
        guard pass == password.value else {
            passwordErrorModel = .incorrectPassword
            return
        }
        sendLoginRequest()
    }
    
    private func sendLoginRequest() {
        Task.init {
            do {
                let isLoggedIn = try await loginUseCase.loginUser(
                    requestModel: LoginRequest(
                        email: email.value,
                        password: password.value
                    )
                )
                DispatchQueue.main.async {
                    if isLoggedIn {
                        self.openDashboard()
                    }
                }
            } catch { print(error) }
        }
    }
}

//MARK: Routing
extension LoginViewModel {
    func openRegister() {
        router.openRegisterController()
    }
    
    func openDashboard() {
        router.openDashboard()
    }
}
