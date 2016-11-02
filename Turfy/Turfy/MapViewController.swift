//
//  SecondViewController.swift
//  Turfy
//
//  Created by Lawrence Dawson on 25/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

struct PreferencesKeys {
    static let savedItems = "savedItems"
}

struct MapVariables {
    static var searchController:UISearchController! = UISearchController(searchResultsController: nil)
    static let regionRadius: CLLocationDistance = 500
    
    static var latitude : Double = 0
    static var longitude : Double = 0
    
    static let locationManager = CLLocationManager()
    static let geoCoder: CLGeocoder! = CLGeocoder()
}

struct DBVariables {
    static var messages: [Message] = []
    static let ref = FIRDatabase.database().reference().child("messages")
    static let inboxRef = FIRDatabase.database().reference().child("messages").child((FIRAuth.auth()?.currentUser?.uid)!)
}

class MapViewController: UIViewController {


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let composeViewController = segue.destination as! ComposeViewController
		MapVariables.latitude = self.map.centerCoordinate.latitude
		MapVariables.longitude = self.map.centerCoordinate.longitude
    }
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBAction func showSearchBar(_ sender: AnyObject) {
        MapVariables.searchController = UISearchController(searchResultsController: nil)
        MapVariables.searchController.hidesNavigationBarDuringPresentation = false
        MapVariables.searchController.searchBar.delegate = self
        present(MapVariables.searchController, animated: true, completion: nil)
    }
    
 
	override func viewDidLoad() {
        
		super.viewDidLoad()
        
        map.delegate = self
        MapVariables.locationManager.delegate = self
        
        MapVariables.locationManager.requestAlwaysAuthorization()
        MapVariables.locationManager.requestLocation()
        MapVariables.locationManager.desiredAccuracy = kCLLocationAccuracyBest

        loadAllMessages()
        startWatchingForMessages()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, MapVariables.regionRadius * 2.0, MapVariables.regionRadius * 2.0)
        self.map.setRegion(coordinateRegion, animated: true)
    }
    
    func geoCode(location : CLLocation!){
        MapVariables.geoCoder.cancelGeocode()
        MapVariables.geoCoder.reverseGeocodeLocation(location, completionHandler: {(data, error) -> Void in
            guard let placeMarks = data as [CLPlacemark]! else
            {return}
            let loc: CLPlacemark = placeMarks[0]
            let addressDict : [NSString:NSObject] = loc.addressDictionary as! [NSString: NSObject]
            let addrList = addressDict["FormattedAddressLines"] as! [String]
            let address = addrList.joined(separator: ", ")
            self.address.text = address
        })
    }
    
    //consider extracting these elsewhere
    
    func startWatchingForMessages() {
        DBVariables.inboxRef.observe(.childAdded, with: { (snapshot) -> Void in
            let message = Message(snapshot: snapshot)
            if message.status.rawValue != "Sent" {
                DBVariables.messages.append(message)
            } else {
                message.status = Status(rawValue: "Delivered")!
                self.addNewMessage(message: message)
                DBVariables.inboxRef.child(message.id).setValue(message.toAnyObject())
            }
        })
    }
    
    func addNewMessage(message: Message) {
        add(message: message)
        startMonitoring(message: message)
        saveAllMessages()
    }
    
    func loadAllMessages() {
		DBVariables.messages = []
        guard let savedItems = UserDefaults.standard.array(forKey: PreferencesKeys.savedItems) else { return }
        for savedItem in savedItems {
            guard let message = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? Message else { continue }
            add(message: message)
        }
    }
    
    func saveAllMessages() {
        var items: [Data] = []
        for message in DBVariables.messages {
            let item = NSKeyedArchiver.archivedData(withRootObject: message)
            items.append(item)
        }
        UserDefaults.standard.set(items, forKey: PreferencesKeys.savedItems)
    }
    
    func add(message: Message) {
		DBVariables.messages.append(message)
        updateMessagesCount()
    }
    
    func remove(message: Message) {
        if let indexInArray = DBVariables.messages.index(of: message) {
            DBVariables.messages.remove(at: indexInArray)
        }
        updateMessagesCount()
    }
    
    func updateMessagesCount() {
        //add a logic to ensure notifications.count < 20, iOS cannot handle more than that and may stop displaying them at all
        print("Messages (\(DBVariables.messages.count))")
    }
    
    func region(withMessage message: Message) -> CLCircularRegion {
        let region = CLCircularRegion(center: message.coordinate, radius: message.radius, identifier: message.id)
        region.notifyOnEntry = (message.eventType == .onEntry)
        region.notifyOnExit = !region.notifyOnEntry
        return region
    }
    
    func startMonitoring(message: Message) {
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            showAlert(withTitle:"Error", message: "This device does not fully support Türfy, some functionalities may not work correctly")
            return
        }
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            showAlert(withTitle:"Warning", message: "Please grant Türfy permission to access the device location (Always on) in order for the app to work correctly")
        }
        let region = self.region(withMessage: message)
		if message.status.rawValue == "Delivered" {
			MapVariables.locationManager.startMonitoring(for: region)
			message.status = Status(rawValue: "Processed")!
			DBVariables.inboxRef.child(message.id).setValue(message.toAnyObject())
		}
    }
    
    func stopMonitoring(message: Message) {
        for region in MapVariables.locationManager.monitoredRegions {
            guard let circularRegion = region as? CLCircularRegion, circularRegion.identifier == message.id else { continue }
            MapVariables.locationManager.stopMonitoring(for: circularRegion)
        }
    }
}
