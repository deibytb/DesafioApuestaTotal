//
//  SplashView.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import SwiftUI

struct SplashView: View {
    @State private var logoScale: CGFloat = 0.4
    @State private var logoOpacity: Double = 0.2
    
    private let width = UIScreen.main.bounds.width * 0.8
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: width)
                .scaleEffect(logoScale)
                .opacity(logoOpacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.2)) {
                        self.logoScale = 1.0
                        self.logoOpacity = 1.0
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SplashView()
}
