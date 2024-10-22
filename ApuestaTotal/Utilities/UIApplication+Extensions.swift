//
//  UIApplication+Extensions.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
