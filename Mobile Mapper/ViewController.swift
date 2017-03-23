//
//  ViewController.swift
//  Mobile Mapper
//
//  Created by student3 on 3/20/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let herseyAnnotation = MKPointAnnotation()
    let address = "Mount Rushmore"
    let geocoder = CLGeocoder()
    let locationManager = CLLocationManager()
    var initialRegion: MKCoordinateRegion!
    var isInitialMapLoad: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        let latitude: Double = 42.102332924
        let longitude: Double = -87.955667844
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        herseyAnnotation.coordinate = coordinate
        herseyAnnotation.title = "Hersey High School"
        mapView.addAnnotation(herseyAnnotation)
        mapView.delegate = self
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            //print(placemarks?.count)
            for place in placemarks!
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = (place.location?.coordinate)!
                annotation.title = place.name
                self.mapView.addAnnotation(annotation)
            }
        }
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    @IBAction func whenButtonTapped(_ sender: UIBarButtonItem)
    {
        mapView.setRegion(initialRegion, animated: true)
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView)
    {
        if isInitialMapLoad
        {
            initialRegion = MKCoordinateRegion(center: mapView.centerCoordinate, span: mapView.region.span)
            isInitialMapLoad = false
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        var pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation.isEqual(mapView.userLocation)
        {
            return nil
        }
        
        if annotation.isEqual(annotation)
        {
            pin.image = UIImage(named: "MobileMakersPin")
        }
            
        else {
            
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        }

        pin.image = UIImage(named: "logo")
        pin.canShowCallout = true
        let button = UIButton(type: .detailDisclosure)
        pin.rightCalloutAccessoryView = button
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: (view.annotation?.coordinate)!, span: span)
        mapView.setRegion(region, animated: true)
    }
}

