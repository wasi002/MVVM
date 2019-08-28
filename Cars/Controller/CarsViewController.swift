//
//  CarsViewController.swift
//  Cars
//
//  Created by Muhammad Waseem on 25/08/2019.
//  Copyright © 2019 Muhammad Waseem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CarsViewController: UIViewController {

    var carListViewModel = CarListViewModel()
    
    let disposeBag = DisposeBag()
    
    @IBOutlet private weak var carsTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
        setupBindings()
        carListViewModel.requestData()
        
    }
    
    private func setupUI() {
        self.title = "Cars"
    }
    
    // MARK: - Bindings
    
    private func setupBindings() {
        
        // binding loading to vc
        
        carListViewModel.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        
        // observing errors to show
        
        carListViewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .error)
                case .serverMessage(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .warning)
                }
            })
            .disposed(by: disposeBag)
        
        
        carsTableView.register(UINib(nibName: "CarCell", bundle: nil), forCellReuseIdentifier: String(describing: CarCell.self))
        
        carListViewModel
            .carViewModels
            .observeOn(MainScheduler.instance)
            .bind(to: carsTableView.rx.items(cellIdentifier: "CarCell", cellType: CarCell.self)){  (row,carViewModel,cell) in
                cell.carViewModel = carViewModel
            }.disposed(by: disposeBag)
        
}

}
