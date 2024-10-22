//
//  TypeFilterHandler.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

class TypeFilterHandler: FilterHandler {
    var next: FilterHandler?
    private let type: BetType?
    
    init(type: BetType?) {
        self.type = type
    }
    
    func filter(_ bets: [BetViewModel]) -> [BetViewModel] {
        let filteredBets = type == nil ? bets : bets.filter { $0.bet.type == type }
        return next?.filter(filteredBets) ?? filteredBets
    }
}
