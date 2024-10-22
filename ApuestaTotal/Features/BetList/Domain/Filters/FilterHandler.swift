//
//  FilterHandler.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 21/10/24.
//

import Foundation

protocol FilterHandler {
    var next: FilterHandler? { get set }
    func filter(_ bets: [BetViewModel]) -> [BetViewModel]
}
