//
//  LocationService.swift
//  Nimesha
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let location_service = CLLocationManager()
    
    @Published var status: CLAuthorizationStatus?
    @Published var last_location: CLLocation?
    @Published var near = false;
    
    var long: Double = 0.0;
    var lati: Double = 0.0;
    
    override init() {
        super.init()
        location_service.delegate = self
        location_service.desiredAccuracy = kCLLocationAccuracyBest
        location_service.requestAlwaysAuthorization()
        location_service.startUpdatingLocation()
    }
    
    var statusString: String {
        guard let status = status else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization st: CLAuthorizationStatus) {
        status = st
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        last_location = location
        let loc_nibm = CLLocation(latitude: self.lati, longitude: self.long)
        let diff = loc_nibm.distance(from: location)
        if(diff<=1000){
            near = true;
        }else{
            near = false;
        }
        
    }
}
