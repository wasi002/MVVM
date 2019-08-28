//
//  CarViewModel.swift
//  Cars
//
//  Created by Muhammad Waseem on 25/08/2019.
//  Copyright © 2019 Muhammad Waseem. All rights reserved.
//

import Foundation

class CarViewModel {
    
    let image: String
    let title: String
    let date: String
    let detail: String

    // Dependency Injection (DI)
    init(car: Car) {
        self.image = car.image ?? ""
        self.title = car.title ?? ""
        
        if let content = car.content , content.count > 0 {
            self.detail = content[0].description ?? ""
        }
        else{
            self.detail = ""
        }
        
        if let createdDate = car.created {
            let dateValue = Date(timeIntervalSince1970: TimeInterval(createdDate))
            date = dateValue.isInSameYear(date: Date()) == true ? dateValue.converToString(dateFormat: Date.Format.withOutYear) : dateValue.converToString(dateFormat: Date.Format.withYear)
        }
        else{
            self.date = ""

        }


        
    }
    
    
}
