//
//  GetBetsUseCase.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import Foundation

protocol GetBetsUseCaseProtocol {
    func execute(completion: @escaping (Result<[BetViewModel], Error>) -> Void)
}

class GetBetsUseCase: GetBetsUseCaseProtocol {
    private let betRepository: BetRepositoryProtocol
    private let betDetailRepository: BetDetailRepositoryProtocol

    init(betRepository: BetRepositoryProtocol = BetRepository(), betDetailRepository: BetDetailRepositoryProtocol = BetDetailRepository()) {
        self.betRepository = betRepository
        self.betDetailRepository = betDetailRepository
    }

    func execute(completion: @escaping (Result<[BetViewModel], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var betsResult: Result<[Bet], Error>?
        var detailsResult: Result<[BetDetail], Error>?
        
        dispatchGroup.enter()
        betRepository.getBets { result in
            betsResult = result
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        betDetailRepository.getBetDetails { result in
            detailsResult = result
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            guard let bets = try? betsResult?.get(), let details = try? detailsResult?.get() else {
                completion(.failure(NSError(domain: "BetUseCaseError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load bets or details"])))
                return
            }
            
            let combinedBets = bets.compactMap { bet -> BetViewModel? in
                guard let detail = details.first(where: { String($0.id) == bet.game }) else {
                    return nil
                }
                return BetViewModel(bet: bet, detail: detail)
            }
            
            completion(.success(combinedBets))
        }
    }
}
