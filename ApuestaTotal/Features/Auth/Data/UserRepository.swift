//
//  AuthRepository.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

protocol UserRepositoryProtocol {
    func getUsers() -> [User]
}

class UserRepository: UserRepositoryProtocol {
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func getUsers() -> [User] {
        return userService.fetchUsers()
    }
}
