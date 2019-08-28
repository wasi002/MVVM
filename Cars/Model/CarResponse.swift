//
//  CarResponse.swift
//  Cars
//
//  Created by Muhammad Waseem on 25/08/2019.
//  Copyright © 2019 Muhammad Waseem. All rights reserved.
//

import Foundation

struct CarResponse : Codable {
    let status : String?
    let cars : [Car]?
    let serverTime : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case cars = "content"
        case serverTime = "serverTime"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        cars = try values.decodeIfPresent([Car].self, forKey: .cars)
        serverTime = try values.decodeIfPresent(Int.self, forKey: .serverTime)
    }
    
}

//// MARK: Convenience initializers


extension CarResponse {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(CarResponse.self, from: data) else { return nil }
        self = me
    }
}
