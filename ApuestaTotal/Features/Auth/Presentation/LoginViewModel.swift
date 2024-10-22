//
//  LoginViewModel.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
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
        DispatchQueue.main.async { self.isLoading = true }
        if let user = validateUserUseCase.execute(correo: correo, password: password) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                self.authenticateUser = user
                self.isAuthenticated = true
                self.errorMessage = nil
                
                DispatchQueue.main.async { self.isLoading = false }
            })
        } else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                self.errorMessage = "Correo o contraseña incorrectos"
                self.isLoading = false
            })
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
