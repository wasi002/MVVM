//
//  CarsTests.swift
//  CarsTests
//
//  Created by Muhammad Waseem on 24/08/2019.
//  Copyright © 2019 Muhammad Waseem. All rights reserved.
//

import XCTest
@testable import Cars

class CarsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    
    func testCarSetGetWithData() {
        
        
        let contentDictioanry = [["type": "text","subject": "Q7","description": "Test Description."]]   as [[String : Any]]
        
        let dic =  ["id": 119302,"title": "Test Title","dateTime": "25.05.2018 14:13","tags": [],"content": contentDictioanry,"ingress": "Test ingress.","image": "https://www.apphusetreach.no/sites/default/files/audi_q7.jpg","created": 1511968425,"changed": 1534311497]  as [String : Any]
        
        
        if let data = Data.convertJsonToData(dic) {
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let car = try jsonDecoder.decode(Car.self, from: data)
                XCTAssertEqual(car.id, 119302)
                XCTAssertEqual(car.title, "Test Title")
                XCTAssertEqual(car.dateTime, "25.05.2018 14:13")
                XCTAssertEqual(car.ingress, "Test ingress.")
                XCTAssertEqual(car.image, "https://www.apphusetreach.no/sites/default/files/audi_q7.jpg")
                XCTAssertEqual(car.created, 1511968425)
                XCTAssertEqual(car.changed, 1534311497)
                
                if let contentArray = car.content {
                    XCTAssertEqual(contentArray.count, 1)
                    let content = contentArray[0]
                    XCTAssertEqual(content.type, "text")
                    XCTAssertEqual(content.subject, "Q7","description")
                    XCTAssertEqual(content.description, "Test Description.")
                }
                
             
            }
            catch {
                print("error")
            }
        }
    }
    
    func testDateConversion(){
        
        let dateValue = Date(timeIntervalSince1970: TimeInterval(1511968425))
        let date = dateValue.isInSameYear(date: Date()) == true ? dateValue.converToString(dateFormat: Date.Format.withOutYear) : dateValue.converToString(dateFormat: Date.Format.withYear)
        
        let formatter : String = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale: NSLocale.current)!
        if formatter.contains("a") {
            XCTAssertEqual(date, "29 November 2017, 08:13 PM")
        } else {
            XCTAssertEqual(date, "29 November 2017, 16:13")
        }
        


    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

