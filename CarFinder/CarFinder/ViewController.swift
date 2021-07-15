//
//  ViewController.swift
//  CarFinder
//
//  Created by Nikhil Subhash Kulkarni on 14/07/21.
//  Copyright © 2021 Nikhil Subhash Kulkarni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var availableCars : [CarModel] = []
    let initialLocation = CLLocation(latitude: 37.773972, longitude:  -122.431297)
    let sanFranciscoCityLocation = CarLocation(title: "San Francisco", coordinate: CLLocationCoordinate2D(latitude: 37.773972, longitude:  -122.431297), info: "Starting Location")
    var carLocations: [CarLocation] = []
    var selectedCarDetail: CarModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var carMapView: MKMapView!
    @IBOutlet weak var reserveCarButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carMapView.delegate = self
        carMapView.centerToLocation(initialLocation)
        
        setupController()
        // Do any additional setup after loading the view.
        
    }
    
    func setupController()
    {
        if let jsonData = readVehicleData(forName: "Test -vehicles_data.")
        {
            parse(jsonData: jsonData)
            var availableCar : CarLocation
            for cardetail in availableCars {
                if let lat = cardetail.lat, let lag = cardetail.lng{
                    availableCar = CarLocation(title:cardetail.license_plate_number + "\n" + cardetail.vehicle_type, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lag), info: cardetail.license_plate_number)
                    self.carMapView.addAnnotation(availableCar)
                } else {
                    availableCar = CarLocation(title: cardetail.vehicle_type, coordinate: CLLocationCoordinate2D(latitude: initialLocation.coordinate.latitude , longitude: initialLocation.coordinate.longitude), info: cardetail.license_plate_number)
                }
                carLocations.append(availableCar)
            }
        }
    }
    private func readVehicleData(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let carsData = try JSONDecoder().decode([CarModel].self,
                                                    from: jsonData)
            self.availableCars = carsData
        } catch {
            print("decode error")
        }
    }
}

extension ViewController: UICollectionViewDelegate,
UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.availableCars.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CarDetailCollectionViewCell",
            for: indexPath
            ) as! CarDetailCollectionViewCell
        cell.carDetail = self.availableCars[indexPath.row]
        cell.update(index: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cardetail = self.availableCars[indexPath.row]
        if let lat = cardetail.lat, let lag = cardetail.lng {
            self.carMapView.centerToLocation(CLLocation(latitude: lat, longitude: lag))
        } else {
            self.carMapView.centerToLocation(initialLocation)
        }
        
    }
}
//MARK:- Mapview Delegate
extension ViewController: MKMapViewDelegate {
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CarLocation else {
            return nil
        }
        
        let identifier = "carannotation"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
import MapKit
import UIKit

class CarLocation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
