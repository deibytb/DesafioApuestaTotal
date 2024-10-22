//
//  BetRepository.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import Foundation

protocol BetRepositoryProtocol {
    func getBets(completion: @escaping (Result<[Bet], Error>) -> Void)
}

class BetRepository: BetRepositoryProtocol {
    private let service: BetServiceProtocol

    init(service: BetServiceProtocol = BetService()) {
        self.service = service
    }

    func getBets(completion: @escaping (Result<[Bet], Error>) -> Void) {
        service.fetchBets(completion: completion)
    }
}
