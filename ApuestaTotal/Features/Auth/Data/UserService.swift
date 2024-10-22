//
//  AuthService.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers() -> [User]
}

class UserService: UserServiceProtocol {
    func fetchUsers() -> [User] {
        guard let users: [User] = loadJSON(file: .user) else {
            return []
        }
        return users
    }
}
