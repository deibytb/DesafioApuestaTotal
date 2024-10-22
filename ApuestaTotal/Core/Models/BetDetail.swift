//
//  BetDetail.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import Foundation

struct BetDetail: Codable, Identifiable {
    let id: Int
    let nivel: BetLevel
    let starts: Int
    let statusName: String
    let typeName: String
    let backgroundSource: String?
    let cashoutOdds: String?
    let totalOdds: String
    let totalStake: String
    let totalWin: String
    let cashoutValue: String?
    let createdDate: String
    let selections: [BetSelection]
    let status: Int
    let type: Int

    enum CodingKeys: String, CodingKey {
        case id = "BetId"
        case nivel = "BetNivel"
        case starts = "BetStarts"
        case statusName = "BetStatusName"
        case typeName = "BetTypeName"
        case backgroundSource = "BgSrc"
        case cashoutOdds = "CashoutOdds"
        case totalOdds = "TotalOdds"
        case totalStake = "TotalStake"
        case totalWin = "TotalWin"
        case cashoutValue = "CashoutValue"
        case createdDate = "CreatedDate"
        case selections = "BetSelections"
        case status = "BetStatus"
        case type = "BetType"
    }
}

enum BetLevel: String, Codable {
    case leyenda = "Leyenda"
    case king = "King"
    case master = "Master"
    case capo = "Capo"
    case cazafijas = "Cazafijas"
    case donatelo = "Donatelo"
    
    var icon: String {
        switch self {
        case .leyenda:
            return "crown.fill"
        case .king:
            return "diamond.inset.filled"
        case .master:
            return "hare.fill"
        case .capo:
            return "gamecontroller.fill"
        case .cazafijas:
            return "binoculars.fill"
        case .donatelo:
            return "slowmo"
        }
    }
}

struct BetSelection: Codable {
    let id = UUID()
    let selectionId: Int
    let status: Int
    let price: String
    let name: String
    let spec: String?
    let marketTypeId: Int
    let marketId: Int
    let marketName: String
    let isLive: Bool
    let isBetBuilder: Bool
    let isBanker: Bool
    let isVirtual: Bool
    let bbSelections: [BBSelection]?
    let eventId: Int
    let eventName: String
    let sportType: BetSportType
    let eventScore: String?
    let categoryName: String?
    let champName: String?

    enum CodingKeys: String, CodingKey {
        case selectionId = "SelectionId"
        case status = "SelectionStatus"
        case price = "Price"
        case name = "Name"
        case spec = "Spec"
        case marketTypeId = "MarketTypeId"
        case marketId = "MarketId"
        case marketName = "MarketName"
        case isLive = "IsLive"
        case isBetBuilder = "IsBetBuilder"
        case isBanker = "IsBanker"
        case isVirtual = "IsVirtual"
        case bbSelections = "BBSelections"
        case eventId = "EventId"
        case eventName = "EventName"
        case sportType = "SportTypeId"
        case eventScore = "EventScore"
        case categoryName = "CategoryName"
        case champName = "ChampName"
    }
}

extension BetSelection {
    var results: (team1Name: String, team1Score: String, team2Name: String, team2Score: String)? {
        guard let score = eventScore else {
            return nil
        }
        
        let teams = eventName.split(separator: " vs. ").map({ String($0) })
        let scores = score.split(separator: ":").map({ String($0) })
        
        guard let team1 = teams.first, let team2 = teams.last, let score1 = scores.first, let score2 = scores.last else {
            return nil
        }
        return (team1Name: team1, team1Score: score1, team2Name: team2, team2Score: score2)
    }
    
    var title: String {
        let marketName = marketName.replacingOccurrences(of: "1x2", with: "Ganador del partido")
        return "\(marketName): \(name)"
    }
}

struct BBSelection: Codable {
    let id = UUID()
    let selectionId: Int
    let name: String
    let marketName: String
    let earlyPayout: Bool
    let boreDraw: Bool
    let status: Int

    enum CodingKeys: String, CodingKey {
        case selectionId = "SelectionId"
        case name = "SelectionName"
        case marketName = "MarketName"
        case earlyPayout = "EarlyPayout"
        case boreDraw = "BoreDraw"
        case status = "SelectionStatus"
    }
}

enum BetSportType: Int, Codable {
    case soccer = 1
    case boxeo = 11
    case basquetball = 12
    case esport = 317
}
