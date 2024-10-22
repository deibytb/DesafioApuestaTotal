//
//  AnimatedCardModifier.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import SwiftUI

struct AnimatedCardModifier: ViewModifier {
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .transition(.move(edge: isVisible ? .trailing : .leading).combined(with: .opacity))
        
            .scaleEffect(isVisible ? 1.0 : 0.8)
            .opacity(isVisible ? 1.0 : 0.8)
            .offset(y: isVisible ? 0 : 50)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.6)) {
                    isVisible = true
                }
            }
            .onDisappear(perform: {
                withAnimation(.easeInOut(duration: 0.6)) {
                    isVisible = false
                }
            })
    }
}

extension View {
    func animatedCard() -> some View {
        self.modifier(AnimatedCardModifier())
    }
}
