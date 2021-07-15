//
//  CarModel.swift
//  CarFinder
//
//  Created by Nikhil Subhash Kulkarni on 14/07/21.
//  Copyright © 2021 Nikhil Subhash Kulkarni. All rights reserved.
//

import Foundation
struct CarModel: Codable {
    let id : Int
    let is_active : Bool
    let is_available : Bool
    let lat : Double?
    let license_plate_number : String
    let lng : Double?
    let pool : String?
    let remaining_mileage : Int
    let remaining_range_in_meters :Double?
    let transmission_mode : String?
    let vehicle_make : String
    let vehicle_pic :String
    let vehicle_pic_absolute_url : String
    let vehicle_type : String
    let vehicle_type_id : Int
}
