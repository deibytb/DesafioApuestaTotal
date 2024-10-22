//
//  BetDetailRepository.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import Foundation

protocol BetDetailRepositoryProtocol {
    func getBetDetails(completion: @escaping (Result<[BetDetail], Error>) -> Void)
}

class BetDetailRepository: BetDetailRepositoryProtocol {
    private let service: BetServiceProtocol

    init(service: BetServiceProtocol = BetService()) {
        self.service = service
    }

    func getBetDetails(completion: @escaping (Result<[BetDetail], Error>) -> Void) {
        service.fetchBetDetails(completion: completion)
    }
}
