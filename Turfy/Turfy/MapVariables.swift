//
//  MapVariables.swift
//  Turfy
//
//  Created by dev on 02/11/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import Firebase
import UIKit

struct MapVariables {
    static var searchController:UISearchController! = UISearchController(searchResultsController: nil)
    static let regionRadius: CLLocationDistance = 500
    
    static var latitude : Double = 0
    static var longitude : Double = 0
    
    static let locationManager = CLLocationManager()
    static let geoCoder: CLGeocoder! = CLGeocoder()
}

class GeoHandler {

    var previousAddress: String!
    var map: MKMapView!
    var address: UILabel!
    
    init(map: MKMapView!, address: UILabel!) {
        self.map = map
        self.address = address
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, MapVariables.regionRadius * 2.0, MapVariables.regionRadius * 2.0)
        self.map.setRegion(coordinateRegion, animated: true)
    }


    func geoCode(location : CLLocation!){
        /* Only one reverse geocoding can be in progress at a time hence we need to cancel existing
         one if we are getting location updates */
        MapVariables.geoCoder.cancelGeocode()
        MapVariables.geoCoder.reverseGeocodeLocation(location, completionHandler: {(data, error) -> Void in
            guard let placeMarks = data as [CLPlacemark]! else
            {return}
            let loc: CLPlacemark = placeMarks[0]
            let addressDict : [NSString:NSObject] = loc.addressDictionary as! [NSString: NSObject]
            let addrList = addressDict["FormattedAddressLines"] as! [String]
            let address = addrList.joined(separator: ", ")
            self.address.text = address
            self.previousAddress = address
    })
    
}
}
