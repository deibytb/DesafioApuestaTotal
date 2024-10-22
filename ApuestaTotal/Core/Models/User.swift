//
//  User.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

struct User: Codable, Identifiable {
    let id = UUID()
    let name: String
    let correo: String
    let password: String
}
