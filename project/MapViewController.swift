//
//  MapViewController.swift
//  project
//
//  Created by saul figueroa on 4/17/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var Map: MKMapView!
    
    let locationManager = CLLocationManager()
    var searchFor:String?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        /*
         self.locationManager.requestWhenInUseAuthorization()
         self.locationManager.delegate = self
         self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
         
         self.locationManager.startUpdatingLocation()
         self.Map.showsUserLocation = true*/
        
        // set the map to phoenix
        let lon : CLLocationDegrees = -112.06
        
        let lat : CLLocationDegrees = 33.45
        
        let coordinates = CLLocationCoordinate2D( latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(coordinates, span)
        
        
        self.Map.setRegion(region, animated: true)
        //searchFor = "vet clinic"
        //search for the correct search
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchFor!
        request.region = Map.region
        
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { response, error in
            guard let response = response else {
                print("There was an error searching for: \(request.naturalLanguageQuery) error: \(error)")
                return
            }
            
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate;
                annotation.title      = item.name;
                annotation.subtitle   = item.placemark.title;
                self.Map.addAnnotation(annotation)
                
                print(item.name!)
            }
            
            
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        self.Map.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }
}
