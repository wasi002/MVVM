//
//  Car.swift
//  Cars
//
//  Created by Muhammad Waseem on 25/08/2019.
//  Copyright © 2019 Muhammad Waseem. All rights reserved.
//

import Foundation

struct Car : Codable {
    let id : Int?
    let title : String?
    let dateTime : String?
    let tags : [String]?
    let content : [Content]?
    let ingress : String?
    let image : String?
    let created : Int?
    let changed : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case dateTime = "dateTime"
        case tags = "tags"
        case content = "content"
        case ingress = "ingress"
        case image = "image"
        case created = "created"
        case changed = "changed"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        content = try values.decodeIfPresent([Content].self, forKey: .content)
        ingress = try values.decodeIfPresent(String.self, forKey: .ingress)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        changed = try values.decodeIfPresent(Int.self, forKey: .changed)
    }
    
}


