//
//  BetListView.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import SwiftUI

struct BetListView: View {
    
    @StateObject private var viewModel = BetListViewModel()
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    @State private var searchText: String = ""
    @State private var selectedStatus: BetStatus? = nil
    @State private var selectedType: BetType? = nil
    @State private var showFilters: Bool = false
    
    let user: User
    
    var body: some View {
        VStack(spacing: 0) {
            customNavBar
            
            VStack {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Cargando...")
                        .font(AppFonts.bold(size: 14))
                    Spacer()
                } else if let errorMessage = viewModel.errorMessage {
                    Spacer()
                    Text("Error: \(errorMessage)")
                        .font(AppFonts.bold(size: 14))
                    Spacer()
                } else {
                    if viewModel.filteredBetViewModels.isEmpty {
                        Spacer()
                        Text("Sin Resultados")
                            .font(AppFonts.bold(size: 14))
                            .padding()
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.filteredBetViewModels) { betViewModel in
                                    BetCardView(data: betViewModel)
                                        .animation(.easeInOut(duration: 0.6), value: betViewModel)
                                        .animatedCard()
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        }
                        .coordinateSpace(name: "scroll")
                        .background(AppColors.background)
                    }
                }
            }
            .navigationTitle("Historial de apuestas")
        }
        .onAppear {
            fetchBets()
        }
        .searchable(text: $searchText, prompt: "Buscar por evento: Perú vs. Chile")
        .onChange(of: searchText) {
            applyFilters()
        }
    }
    
    var customNavBar: some View {
        VStack(spacing: 8) {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        authViewModel.logout()
                    }) {
                        HStack(spacing: 6) {
                            Text("Cerrar sesión")
                                .font(AppFonts.bold(size: 14))
                                .foregroundColor(AppColors.cardBackground)
                            Image(systemName: "door.left.hand.open")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(AppColors.cardBackground)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(AppColors.text)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                HStack(alignment: .bottom) {
                    Text("Bienvenido, \(user.name)")
                        .font(AppFonts.bold(size: 24))
                        .foregroundStyle(AppColors.cardBackground)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
            
            VStack {
                HStack(spacing: 12) {
                    searchField
                    Button(action: {
                        withAnimation {
                            showFilters.toggle()
                        }
                    }) {
                        Image(systemName: showFilters ? "line.horizontal.3.decrease.circle.fill" : "line.horizontal.3.decrease.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(AppColors.cardBackground)
                    }
                    .padding(.trailing)
                }
                
                if showFilters {
                    filters
                }
            }
            .padding(.bottom, 8)
        }
        .background(AppColors.primary)
    }
    
    var searchField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(AppColors.secondary)
                .padding(.horizontal, 8)
            TextField("Buscar por evento: Perú vs. Chile", text: $searchText)
                .textFieldStyle(.plain)
                .font(AppFonts.regular(size: 15))
                .foregroundColor(AppColors.text)
                .padding(.leading, -8)
                .padding(.trailing, 8)
                .onChange(of: searchText) {
                    applyFilters()
                }
        }
        .padding(.vertical, 8)
        .background(AppColors.cardBackground)
        .cornerRadius(8)
        .padding(.leading)
    }
    
    var filters: some View {
        HStack(spacing: 8) {
            Picker("Estado", selection: $selectedStatus) {
                Text("Todos").tag(BetStatus?.none)
                Text("Ganada").tag(BetStatus?.some(.won))
                Text("Perdida").tag(BetStatus?.some(.lost))
                Text("Cash-out ").tag(BetStatus?.some(.cashout))
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedStatus) {
                applyFilters()
            }
            Picker("Tipo", selection: $selectedType) {
                Text("Todos").tag(BetType?.none)
                Text("Simple").tag(BetType?.some(.simple))
                Text("Múltiple").tag(BetType?.some(.multiple))
            }
            .scaleEffect(0.8)
            .pickerStyle(.menu)
            .tint(AppColors.text)
            .onChange(of: selectedType) {
                applyFilters()
            }
        }
        .padding(.horizontal)
    }
    
    private func fetchBets() {
        withAnimation {
            viewModel.fetchBets()
        }
    }
    
    private func applyFilters() {
        withAnimation {
            viewModel.applyFilters(status: selectedStatus, type: selectedType, searchText: searchText)
        }
    }
}

#Preview {
    BetListView(user: User(name: "Deiby", correo: "deibytb@outlook.com", password: "123456"))
}
