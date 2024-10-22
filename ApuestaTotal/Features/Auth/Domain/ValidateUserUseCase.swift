//
//  ValidateUserUseCase.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

protocol ValidateUserUseCaseProtocol {
    func execute(correo: String, password: String) -> User?
}

class ValidateUserUseCase: ValidateUserUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }
    
    func execute(correo: String, password: String) -> User? {
        let users = userRepository.getUsers()
        return users.first { $0.correo == correo && $0.password == password }
    }
}
