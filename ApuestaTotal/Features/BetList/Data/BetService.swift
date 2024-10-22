//
//  BetService.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import Foundation

protocol BetServiceProtocol {
    func fetchBets(completion: @escaping (Result<[Bet], Error>) -> Void)
    func fetchBetDetails(completion: @escaping (Result<[BetDetail], Error>) -> Void)
}

class BetService: BetServiceProtocol {
    func fetchBets(completion: @escaping (Result<[Bet], Error>) -> Void) {
        if let bets: [Bet] = loadJSON(file: .betsAll) {
            completion(.success(bets))
        } else {
            completion(.failure(NSError(domain: "BetServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load bets"])))
        }
    }
    
    func fetchBetDetails(completion: @escaping (Result<[BetDetail], Error>) -> Void) {
        if let betDetails: [BetDetail] = loadJSON(file: .betsDetailsAll) {
            completion(.success(betDetails))
        } else {
            completion(.failure(NSError(domain: "BetServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load bet details"])))
        }
    }
}
