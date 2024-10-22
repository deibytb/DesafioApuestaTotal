//
//  JSONLoader.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import Foundation

enum JSONFile {
    case betsAll
    case betsDetailsAll
    case user

    var fileName: String {
        switch self {
        case .betsAll:
            return "betsAll"
        case .betsDetailsAll:
            return "betsDetailsAll"
        case .user:
            return "user"
        }
    }
    
    var type: Decodable.Type {
        switch self {
        case .betsAll:
            return [Bet].self
        case .betsDetailsAll:
            return [BetDetail].self
        case .user:
            return [User].self
        }
    }
}

func loadJSON<T: Decodable>(file: JSONFile) -> T? {
    guard let url = Bundle.main.url(forResource: file.fileName, withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        print("Error: Could not find or load \(file.fileName).json")
        return nil
    }
    
    let decoder = JSONDecoder()
    do {
        guard let decodedData = try decoder.decode(file.type, from: data) as? T else {
            print("Error: Type mismatch for \(file.fileName).json")
            return nil
        }
        return decodedData
    } catch {
        print("Error decoding \(file.fileName): \(error)")
        return nil
    }
}
