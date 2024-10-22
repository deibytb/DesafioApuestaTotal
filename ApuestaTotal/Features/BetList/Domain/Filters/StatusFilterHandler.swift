//
//  StatusFilterHandler.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

class StatusFilterHandler: FilterHandler {
    var next: FilterHandler?
    private let status: BetStatus?
    
    init(status: BetStatus?) {
        self.status = status
    }
    
    func filter(_ bets: [BetViewModel]) -> [BetViewModel] {
        let filteredBets = status == nil ? bets : bets.filter { $0.bet.status == status }
        return next?.filter(filteredBets) ?? filteredBets
    }
}
