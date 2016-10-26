//
//  SecondViewController.swift
//  Turfy
//
//  Created by Lawrence Dawson on 25/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let regionRadius: CLLocationDistance = 500
    
    

    @IBOutlet weak var map: MKMapView!
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    

    
	override func viewDidLoad() {
        
		super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let initialLocation = CLLocation(latitude: 51.508182, longitude: -0.126771)
        centerMapOnLocation(location: initialLocation)
        map.delegate = self
        let pin = Pin(title: "London", locationName: "Current Location", discipline: "Location", coordinate: CLLocationCoordinate2D (latitude: 51.508182, longitude: -0.126771))
        map.addAnnotation(pin)
        
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    
    


}

