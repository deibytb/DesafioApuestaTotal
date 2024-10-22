//
//  FilterBetsUseCase.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

protocol FilterBetsUseCaseProtocol {
    func execute(bets: [BetViewModel], status: BetStatus?, type: BetType?, searchText: String) -> [BetViewModel]
}

struct FilterBetsUseCase: FilterBetsUseCaseProtocol {
    func execute(bets: [BetViewModel], status: BetStatus?, type: BetType?, searchText: String) -> [BetViewModel] {
        // Crear y configurar la cadena de filtros
        let statusHandler = StatusFilterHandler(status: status)
        let typeHandler = TypeFilterHandler(type: type)
        let searchTextHandler = SearchTextFilterHandler(searchText: searchText)
        
        // Encadenar los handlers
        statusHandler.next = typeHandler
        typeHandler.next = searchTextHandler
        
        // Aplicar los filtros usando la cadena
        return statusHandler.filter(bets)
    }
}
