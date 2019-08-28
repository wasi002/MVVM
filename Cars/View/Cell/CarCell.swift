//
//  CarCell.swift
//  Cars
//
//  Created by Muhammad Waseem on 25/08/2019.
//  Copyright © 2019 Muhammad Waseem. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carTitle: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var carDetail: UILabel!
    @IBOutlet weak var gradient: UIImageView!
    
    
    var carViewModel: CarViewModel! {
        didSet {
            self.carImage.loadImage(fromURL: carViewModel.image)
            self.carTitle.text = carViewModel.title
            self.publishDate.text =  carViewModel.date
            self.carDetail.text =  carViewModel.detail
       }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.gradient.image = #imageLiteral(resourceName: "gradient")
        self.carTitle.sizeToFit()
        self.carDetail.sizeToFit()
    }
    
    
    override func prepareForReuse() {
       carImage.image = UIImage.init(named: "placeholder")
    }


}
