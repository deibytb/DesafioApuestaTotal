//
//  LoginViewModel.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var correo: String = "deibytb@outlook.com"
    @Published var password: String = "123456"
    @Published var emailIsValid: Bool?
    @Published var formIsValid: Bool = false
    
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    @Published var authenticateUser: User?
    
    private let validateUserUseCase: ValidateUserUseCaseProtocol
    private let validateEmailUseCase: ValidateEmailUseCaseProtocol
    
    init(validateUserUseCase: ValidateUserUseCaseProtocol = ValidateUserUseCase(),
         validateEmailUseCase: ValidateEmailUseCaseProtocol = ValidateEmailUseCase()) {
        self.validateUserUseCase = validateUserUseCase
        self.validateEmailUseCase = validateEmailUseCase
    }
    
    func login() {
        if let user = validateUserUseCase.execute(correo: correo, password: password) {
            authenticateUser = user
            isAuthenticated = true
            errorMessage = nil
        } else {
            errorMessage = "Correo o contraseña incorrectos"
        }
    }
    
    func validateEmail() {
        if correo.count > 0 {
            emailIsValid = validateEmailUseCase.execute(email: correo)
        } else {
            emailIsValid = nil
        }
    }
    
    func validateForm() {
        guard let emailIsVaild = emailIsValid else {
            return
        }
        formIsValid = (emailIsVaild && password.count >= 4)
    }
}
