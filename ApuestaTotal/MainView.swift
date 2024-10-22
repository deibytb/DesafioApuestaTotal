//
//  MainView.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var showSplash: Bool = true
    
    var body: some View {
        if showSplash {
            SplashView()
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.showSplash = false
                        }
                    }
                })
        } else {
            LoginView()
        }
    }
}

#Preview {
    MainView()
}
