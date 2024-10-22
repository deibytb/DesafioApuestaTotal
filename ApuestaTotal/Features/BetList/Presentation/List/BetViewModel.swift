//
//  BetViewModel.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import Foundation
import SwiftUI

struct BetViewModel: Identifiable, Equatable {
    static func == (lhs: BetViewModel, rhs: BetViewModel) -> Bool { lhs.id == rhs.id }
    
    let id = UUID()
    let bet: Bet
    let detail: BetDetail
}

extension BetViewModel {
    
    var level: BetLevel {
        return detail.nivel
    }
    
    var typeTitle: String {
        switch type {
        case .simple:
            if let betSelection = detail.selections.first, let bbSelections = betSelection.bbSelections {
                return "\(type.rawValue) x\(bbSelections.count)"
            } else {
                return type.rawValue
            }
        case .multiple:
            return "\(type.rawValue) x\(detail.selections.count)"
        }
    }
    
    var type: BetType {
        return bet.type
    }
    
    var status: BetStatus {
        return bet.status
    }
    
    var date: String {
        return bet.createdDate
    }
    
    var title: String {
        switch bet.type {
        case .simple:
            guard let betSelection = detail.selections.first else {
                return ""
            }
            
            if betSelection.bbSelections != nil {
                return betSelection.name.replacingOccurrences(of: "1x2", with: "Ganador del partido")
            } else {
                return betSelection.title
            }
        case .multiple:
            let titles = detail.selections.map { selection in
                return selection.title
            }
            return titles.joined(separator: " | ")
        }
    }
    
    var event: String? {
        if detail.selections.count > 1 {
            return nil
        } else {
            return detail.selections.first?.eventName
        }
    }
    
    var amount: String {
        return "S/\(detail.totalStake)"
    }
    
    var odd: String {
        return detail.totalOdds
    }
    
    var payment: String? {
        guard let doubleValue = Double(detail.totalWin), doubleValue > 0 else {
            return nil
        }
        return "S/\(detail.totalWin)"
    }
    
    var icon: String {
        return detail.nivel.icon
    }
}
