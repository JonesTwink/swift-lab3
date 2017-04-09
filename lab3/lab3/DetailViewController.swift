//
//  DetailViewController.swift
//
//
//  Created by Admin on 05.04.17.
//
//

import UIKit
import SwiftyJSON
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var region: UILabel!
    
    @IBOutlet weak var regionDesc: UILabel!
    @IBOutlet weak var regionTemperature: UILabel!
    
    let annotation = MKPointAnnotation()
    
    var regionInfo : [String:String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        region.text = regionInfo["region"]
        regionDesc.text = regionInfo["description"]
        regionTemperature.text = regionInfo["temperature"]
        
        self.mapView.delegate = self
        let regionLocation = CLLocationCoordinate2D(latitude: Double(regionInfo["geoLat"]!)!, longitude :  Double(regionInfo["geoLon"]!)!)

        annotation.coordinate = regionLocation
        annotation.title = regionInfo["region"]
        annotation.subtitle = regionInfo["temperature"]! + " | " + regionInfo["description"]!
        mapView.addAnnotation(annotation)
        mapView.centerCoordinate = regionLocation
        //mapView.showAnnotations(mapView.annotations, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if ((mapView.region.span.latitudeDelta > 3) || (mapView.region.span.longitudeDelta > 3) ) {
            
            let centerCoord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(regionInfo["geoLat"]!)!, Double(regionInfo["geoLon"]!)!);
            let spanOfBelarus:MKCoordinateSpan = MKCoordinateSpanMake(3, 3);
            let NZRegion:MKCoordinateRegion = MKCoordinateRegionMake(centerCoord, spanOfBelarus);
            mapView .setRegion(NZRegion, animated: true);
            
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
