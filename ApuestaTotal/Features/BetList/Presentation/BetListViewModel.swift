//
//  BetListViewModel.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import Foundation
import SwiftUI

class BetListViewModel: ObservableObject {
    
    @Published var filteredBetViewModels: [BetViewModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var betViewModels: [BetViewModel] = []
    
    private let getBetsUseCase: GetBetsUseCaseProtocol
    private let filterBetsUseCase: FilterBetsUseCaseProtocol

    init(getBetsUseCase: GetBetsUseCaseProtocol = GetBetsUseCase(),
         filterBetsUseCase: FilterBetsUseCaseProtocol = FilterBetsUseCase()) {
        self.getBetsUseCase = getBetsUseCase
        self.filterBetsUseCase = filterBetsUseCase
    }

    func fetchBets() {
        DispatchQueue.main.async { self.isLoading = true }
        getBetsUseCase.execute { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let betViewModels):
                    self.betViewModels = betViewModels
                    self.filteredBetViewModels = self.betViewModels
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func applyFilters(status: BetStatus?, type: BetType?, searchText: String) {
        filteredBetViewModels = filterBetsUseCase.execute(
            bets: betViewModels,
            status: status,
            type: type,
            searchText: searchText
        )
    }
}
