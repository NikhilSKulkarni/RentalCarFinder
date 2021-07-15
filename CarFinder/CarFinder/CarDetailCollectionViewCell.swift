//
//  CarDetailCollectionViewCell.swift
//  CarFinder
//
//  Created by Nikhil Subhash Kulkarni on 15/07/21.
//  Copyright © 2021 Nikhil Subhash Kulkarni. All rights reserved.
//

import UIKit

class CarDetailCollectionViewCell: UICollectionViewCell {
    var carDetail : CarModel?
    @IBOutlet weak var carNameLable : UILabel!
    @IBOutlet weak var carNumberLabel : UILabel!
    @IBOutlet weak var remainingMiledgePercentageLbl : UILabel!
    @IBOutlet weak var carKilometerLabel : UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    func update(index: Int) {
        if let carname = self.carDetail?.vehicle_type {
            self.carNameLable?.text = carname
        }
        remainingMiledgePercentageLbl.text = "\(carDetail?.remaining_mileage ?? 0) %"
        carNumberLabel.text = self.carDetail?.license_plate_number ?? ""
        if let remMiledge = self.carDetail?.remaining_range_in_meters {
            let km = round(remMiledge / 1000)
            carKilometerLabel.text = "\(km) km"
        }
        
//        debugPrint("CarType", self.carDetail!)
        if let downloadurl = carDetail?.vehicle_pic_absolute_url {
            let url  = URL(string: downloadurl)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.carImageView.image = UIImage(data: data!)
                }
            }
        }
    }
}
