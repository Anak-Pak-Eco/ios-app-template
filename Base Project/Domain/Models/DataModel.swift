//
//  DataModel.swift
//  Base Project
//
//  Created by Leonardo Jose Gunawan on 05/10/23.
//

import Foundation

class DataModel: Encodable, Decodable {
    var current_TDS: Float = 0.0
    var current_pH: Float = 0.0
//    var value: String = ""
}

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }

        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
