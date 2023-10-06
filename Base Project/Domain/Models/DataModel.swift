//
//  DataModel.swift
//  Base Project
//
//  Created by Leonardo Jose Gunawan on 05/10/23.
//

import Foundation

struct DataModel: Codable {
    var devices: [String: Device]
}

struct Device: Codable {
    
    var current_ph: Double
    var current_steps: String
    var current_tds: Double
    var name: String
    var plant_id: String
    var user_id: String
    
    func toDictionary() -> [String: Any] {
            return [
                "current_ph": current_ph,
                "current_steps": current_steps,
                "current_tds": current_tds,
                "name": name,
                "plant_id": plant_id,
                "user_id": user_id
            ]
        }
    
}

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }

        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
