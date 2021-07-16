//
//  CarAnnotation.swift
//  CarFinder
//
//  Created by Nikhil Subhash Kulkarni on 14/07/21.
//  Copyright © 2021 Nikhil Subhash Kulkarni. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class CarAnnotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
