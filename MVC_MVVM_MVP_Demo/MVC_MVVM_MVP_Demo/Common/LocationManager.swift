//
//  LocationManager.swift
//  MVC_MVVM_MVP_Demo
//
//

import CoreLocation
import Foundation

// gives user location
class LocationManager: NSObject, CLLocationManagerDelegate {
    private(set) var userLocation: CLLocation? {
        didSet {
           // print("location ser")
        }
    }
    private var locationManager: CLLocationManager!

    var lat: String {
        if let latitude = LocationManager.shared.userLocation?.coordinate.latitude {
            return "\(latitude)"
        }

        return "0"
    }

    var long: String {
        if let longitude = LocationManager.shared.userLocation?.coordinate.longitude {
            return "\(longitude)"
        }

        return "0"
    }

    static let shared = LocationManager()

    override init() {
        super.init()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }

    func start() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func stop() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
        }
    }
    
    func isEnabed() -> Bool {
        var status = false
        let authorizationStatus: CLAuthorizationStatus

        if #available(iOS 14, *) {
            authorizationStatus = CLLocationManager().authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        if CLLocationManager.locationServicesEnabled() {
            switch authorizationStatus {
                case .notDetermined, .restricted, .denied:
                   status = false
                case .authorizedAlways, .authorizedWhenInUse:
                    status = true
                @unknown default:
                break
            }
            } else {
                print("Location services are not enabled")
        }
        return status
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        self.userLocation = userLocation
     //   debugLog("user latitude = \(userLocation.coordinate.latitude)")
       // debugLog("user longitude = \(userLocation.coordinate.longitude)")
    }

    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}
