//
//  SecondViewController.swift
//  lab3
//
//  Created by Admin on 03.04.17.
//  Copyright © 2017 arthur. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController,  MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var weather: [AnyObject] = []
       let annotation = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView.delegate = self
        
        WeatherService.getRawWeatherArray { (result: [AnyObject]) in
            self.weather = result
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mapView.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleTap(_ sender: UITapGestureRecognizer) {
        //if sender.state != UIGestureRecognizerState.began { return }
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        let closestRegion = WeatherService.findNearestPlace(lat: locationCoordinate.latitude, lon: locationCoordinate.longitude)
        
        print(closestRegion)
        addAnnotation(data: closestRegion)
        
    }
    
    func addAnnotation(data: [String:String]){
     
        let regionLocation = CLLocationCoordinate2D(latitude: Double(data["geoLat"]!)!, longitude :  Double(data["geoLon"]!)!)
        annotation.coordinate = regionLocation
        annotation.title = data["region"]
        annotation.subtitle = data["temperature"]! + " | " + data["description"]!
        mapView.addAnnotation(annotation)

        mapView.selectAnnotation(annotation, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView){
        mapView.selectAnnotation(annotation, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if ((mapView.region.span.latitudeDelta > 3) || (mapView.region.span.longitudeDelta > 3) ) {
            
            let centerCoord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(53, 28);
            let spanOfBelarus:MKCoordinateSpan = MKCoordinateSpanMake(10, 10);
            let NZRegion:MKCoordinateRegion = MKCoordinateRegionMake(centerCoord, spanOfBelarus);
            mapView .setRegion(NZRegion, animated: true);
            
        }
    }
}

