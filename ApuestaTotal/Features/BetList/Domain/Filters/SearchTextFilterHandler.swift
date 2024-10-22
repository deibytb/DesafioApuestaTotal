//
//  SearchTextFilterHandler.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

class SearchTextFilterHandler: FilterHandler {
    var next: FilterHandler?
    private let searchText: String
    
    init(searchText: String) {
        self.searchText = searchText
    }
    
    func filter(_ bets: [BetViewModel]) -> [BetViewModel] {
        guard !searchText.isEmpty else {
            return next?.filter(bets) ?? bets
        }
        
        let searchTextLowercased = searchText.lowercased()
        let filteredBets = bets.filter { bet in
            if bet.detail.selections.count > 1 {
                let eventNames = bet.detail.selections.map({ $0.eventName.lowercased() }).joined(separator: " | ")
                return eventNames.contains(searchTextLowercased)
            } else {
                if let selection = bet.detail.selections.first {
                    return selection.eventName.lowercased().contains(searchTextLowercased)
                } else {
                    return false
                }
            }
        }
        return next?.filter(filteredBets) ?? filteredBets
    }
}
