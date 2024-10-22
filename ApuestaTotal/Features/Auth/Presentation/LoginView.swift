//
//  LoginView.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .padding(.top, 120)
                    .padding(.bottom, 40)
                
                Text("Iniciar Sesión")
                    .font(AppFonts.bold(size: 24))
                    .foregroundStyle(AppColors.text)
                
                VStack {
                    TextField("Correo", text: $viewModel.correo)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .font(AppFonts.regular(size: 16))
                        .background(AppColors.cardBackground)
                        .cornerRadius(8)
                        .onChange(of: viewModel.correo) {
                            viewModel.validateEmail()
                            viewModel.validateForm()
                        }
                    if let emailIsValid = viewModel.emailIsValid, !emailIsValid {
                        Text("Formato de correo no válido")
                            .font(AppFonts.regular(size: 14))
                            .foregroundColor(AppColors.primary)
                    }
                }
                
                SecureField("Contraseña", text: $viewModel.password)
                    .textContentType(.password)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .font(AppFonts.regular(size: 16))
                    .background(AppColors.cardBackground)
                    .cornerRadius(8)
                    .onChange(of: viewModel.password) {
                        viewModel.validateForm()
                    }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(AppFonts.regular(size: 14))
                        .foregroundColor(AppColors.primary)
                }
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Iniciar Sesión")
                        .font(AppFonts.bold(size: 16))
                        .foregroundColor(viewModel.formIsValid ? AppColors.cardBackground : AppColors.background)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(viewModel.formIsValid ? AppColors.primary : AppColors.secondary)
                        .cornerRadius(8)
                }
                .disabled(viewModel.formIsValid ? false : true)
                .onChange(of: viewModel.isAuthenticated) { oldValue, newValue in
                    if newValue {
                        authViewModel.login()
                    }
                }
                
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .onAppear(perform: {
                viewModel.validateEmail()
                viewModel.validateForm()
            })
        }
        .background(AppColors.background)
        .dismissKeyboardOnTap()
        .fullScreenCover(isPresented: $authViewModel.isAuthenticated) {
            if let user = viewModel.authenticateUser {
                BetListView(user: user)
            }
        }
        .onChange(of: authViewModel.isAuthenticated) { oldValue, newValue in
            if !newValue {
                viewModel.isAuthenticated = false
            }
        }
    }
}

#Preview {
    LoginView().environmentObject(AuthenticationViewModel())
}
