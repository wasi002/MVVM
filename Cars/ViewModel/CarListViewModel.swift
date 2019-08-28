//
//  CarListViewModel.swift
//  Cars
//
//  Created by Muhammad Waseem on 25/08/2019.
//  Copyright © 2019 Muhammad Waseem. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class CarListViewModel {
    
    public enum CarError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let carViewModels : PublishSubject<[CarViewModel]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<CarError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    
    public func requestData(){
        
        self.loading.onNext(true)
        APIManager.requestData(url: "article/get_articles_list", method: .get, parameters: nil, completion: { (result) in
            self.loading.onNext(false)
            switch result {
            case .success(let returnData) :
                
                let carsResponse = CarResponse(data:  returnData)
                if carsResponse?.status == "success", let cars = carsResponse?.cars {
                    
                    if Storage.fileExists("cars.json", in: .documents) {
                        Storage.clear(.documents)
                    }
                    
                    Storage.store(cars, to: .documents, as: "cars.json")

                     let carVModels = cars.map({return CarViewModel(car: $0)})
                     self.carViewModels.onNext(carVModels)
                }
                else{
                    self.error.onNext(.serverMessage(carsResponse?.status ?? ""))
                }
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error.onNext(.internetError("Check your Internet connection."))
                case .authorizationError(let errorJson):
                    self.error.onNext(.serverMessage(errorJson["message"].stringValue))
                default:
                    self.error.onNext(.serverMessage("Unknown Error"))
                }
                if Storage.fileExists("cars.json", in: .documents) {
                    let carFromDisk = Storage.retrieve("cars.json", from: .documents, as: [Car].self)
                    let carVModels = carFromDisk.map({return CarViewModel(car: $0)})
                    self.carViewModels.onNext(carVModels)

                }
            }
        })
        
    }
}
