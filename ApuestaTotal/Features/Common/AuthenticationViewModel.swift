//
//  AuthenticationViewModel.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation
import SwiftUI

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    func login() {
        isAuthenticated = true
    }
    
    func logout() {
        isAuthenticated = false
    }
}
