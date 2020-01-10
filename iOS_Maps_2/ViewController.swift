//
//  ViewController.swift
//  iOS_Maps_2
//
//  Created by MacStudent on 2020-01-10.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
 import MapKit
class ViewController: UIViewController,CLLocationManagerDelegate {

    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    let places = Place.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        addAnnotations()
        mapView.showsUserLocation=true
        addPolyLine()
        
    }

    
    func addPolyLine() {
        let locations = places.map{$0.coordinate}
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        mapView.addOverlay(polyline)
    }
    
    func addAnnotations(){
        mapView.delegate = self
        mapView.addAnnotations(places)
        
        let overlays = places.map { (MKCircle(center: $0.coordinate, radius: 10000))
            
        }
        mapView.addOverlays(overlays)
    }

    // this func is used to add overlays
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle{
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
        renderer.strokeColor = UIColor.green
        renderer.lineWidth = 2
        return renderer
        }
        else if overlay is MKPolyline{
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 3
            return renderer
            
        }
        return MKOverlayRenderer()
    }
 
}

extension ViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        else{
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.image=UIImage(named: "ic_place")
        return annotationView
        }
    }
 }
 
