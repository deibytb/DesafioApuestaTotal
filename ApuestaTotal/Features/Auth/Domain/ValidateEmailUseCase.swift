//
//  ValidateEmailUseCase.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

protocol ValidateEmailUseCaseProtocol {
    func execute(email: String) -> Bool
}

class ValidateEmailUseCase: ValidateEmailUseCaseProtocol {
    func execute(email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
