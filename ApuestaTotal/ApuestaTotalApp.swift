//
//  ApuestaTotalApp.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import SwiftUI

@main
struct ApuestaTotalApp: App {
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authViewModel)
        }
    }
}
