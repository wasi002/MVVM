//
//  Content.swift
//  Cars
//
//  Created by Muhammad Waseem on 25/08/2019.
//  Copyright © 2019 Muhammad Waseem. All rights reserved.
//

import Foundation

struct Content : Codable {
    let type : String?
    let subject : String?
    let description : String?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case subject = "subject"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        subject = try values.decodeIfPresent(String.self, forKey: .subject)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
    
}

