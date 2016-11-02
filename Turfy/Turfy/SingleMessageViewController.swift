//
//  SingleMessageViewController.swift
//  Turfy
//
//  Created by Joseph Huang on 31/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import MapKit

class SingleMessageViewController: UIViewController {

    let regionRadius: CLLocationDistance = 500
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordMessage!, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }


    var textMessage = ""
    var coordMessage: CLLocationCoordinate2D? = nil
  //  var messageObject["latitude"]: Int
 //   messageObject["latitude"] = 50
 //   var messageObject.longitude = 50
    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Pin {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTitle.text = textMessage
        
        
        let initialLocation = coordMessage
        centerMapOnLocation(location: initialLocation!)

        let pin = Pin(title: "London", locationName: "Current Location", discipline: "Location", coordinate: coordMessage!)
        mapView.addAnnotation(pin)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
