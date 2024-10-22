//
//  Bet.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import Foundation
import SwiftUI

struct Bet: Codable, Identifiable {
    let id = UUID()
    let db: Int
    let operation: Int
    let game: String
    let createdDate: String
    let status: BetStatus
    let wager: Double
    let winning: Double?
    let odds: Double
    let type: BetType
    let account: Account

    enum CodingKeys: String, CodingKey {
        case db
        case operation
        case game
        case createdDate = "created_date"
        case status
        case wager
        case winning
        case odds
        case type
        case account
    }
}

enum BetStatus: String, Codable {
    case won = "WON"
    case lost = "LOST"
    case cashout = "CASHOUT"
    
    var title: String {
        switch self {
        case .won: return "GANADA"
        case .lost: return "PERDIDA"
        case .cashout: return "CASH-OUT"
        }
    }
    
    var color: Color {
        switch self {
        case .won:
            AppColors.accent
        case .lost:
            AppColors.primary
        case .cashout:
            Color.blue
        }
    }
}

enum BetType: String, Codable {
    case simple = "SIMPLE"
    case multiple = "MULTIPLE"
}

enum Account: String, Codable {
    case cash = "CASH"
    case bonus = "BETTING-BONUS"
}
