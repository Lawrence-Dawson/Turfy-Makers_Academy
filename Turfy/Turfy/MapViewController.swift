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

struct PreferencesKeys {
    static let savedItems = "savedItems"
}

class MapViewController: UIViewController {

    let regionRadius: CLLocationDistance = 500
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    var notifications: [Notification] = []

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let composeViewController = segue.destination as! ComposeViewController
        composeViewController.latitude = self.map.centerCoordinate.latitude
        composeViewController.longitude = self.map.centerCoordinate.longitude
    }

    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBAction func showSearchBar(_ sender: AnyObject) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    var geoCoder: CLGeocoder!
    let locationManager = CLLocationManager()
    var previousAddress: String!
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }

    

    
    func geoCode(location : CLLocation!){
        /* Only one reverse geocoding can be in progress at a time hence we need to cancel existing
         one if we are getting location updates */
        geoCoder.cancelGeocode()
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(data, error) -> Void in
            guard let placeMarks = data as [CLPlacemark]! else
            {return}
            let loc: CLPlacemark = placeMarks[0]
            let addressDict : [NSString:NSObject] = loc.addressDictionary as! [NSString: NSObject]
            let addrList = addressDict["FormattedAddressLines"] as! [String]
            let address = addrList.joined(separator: ", ")
            print(address)
            self.address.text = address
            self.previousAddress = address
        })
        
    }

	override func viewDidLoad() {
        
		super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        geoCoder = CLGeocoder()
        
        loadAllNotifications()
        
        let initialLocation = CLLocation(latitude: 51.508182, longitude: -0.126771)
        centerMapOnLocation(location: initialLocation)
        map.delegate = self
        let pin = Pin(title: "London", locationName: "Current Location", discipline: "Location", coordinate: CLLocationCoordinate2D (latitude: 51.508182, longitude: -0.126771))
        map.addAnnotation(pin)
        
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Hardcoded radius, coordinates (Makers Academy)
        
        let coordinateToWatch : CLLocationCoordinate2D = CLLocationCoordinate2D (latitude: 51.5173, longitude: 0.0733)
        let radiusOfFence : Double = 5000
        let notificationId = "ATestNotification"
        let messageSender = "Johnny"
        let messageContent = "I AM WATCHING YOU!"
        let eventType = "On Entry"
        
        let clampedRadius = min(radiusOfFence, locationManager.maximumRegionMonitoringDistance)
        
        let notificationToAdd : Notification = Notification(coordinate: coordinateToWatch, radius: radiusOfFence, identifier: notificationId, sender: messageSender, message: messageContent, eventType: EventType(rawValue: eventType)!)
        
        addNewNotification(notification: notificationToAdd)
        
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    func addNewNotification(notification: Notification) {
        add(notification: notification)
        startMonitoring(notification: notification)
        saveAllNotifications()
    }
    
    func loadAllNotifications() {
        notifications = []
        guard let savedItems = UserDefaults.standard.array(forKey: PreferencesKeys.savedItems) else { return }
        for savedItem in savedItems {
            guard let notification = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? Notification else { continue }
            add(notification: notification)
        }
    }
    
    func saveAllNotifications() {
        var items: [Data] = []
        for notification in notifications {
            let item = NSKeyedArchiver.archivedData(withRootObject: notification)
            items.append(item)
        }
    }
    
    func add(notification: Notification) {
        notifications.append(notification)
        // should we display them on the map too???
        // map.addAnnotation(notification)
        // addRadiusOverlay(forNotification: notifications)
        // also, may be good to call a method updating status of the message to 'delivered'?
        // (tbd)
        updateNotificationsCount()
    }
    
    func remove(notification: Notification) {
        if let indexInArray = notifications.index(of: notification) {
            notifications.remove(at: indexInArray)
        }
        // map.removeAnnotion(notification)
        // removeRadiusOverlay(forNotification: notification)
        updateNotificationsCount()
    }
    
    func updateNotificationsCount() {
        //title = "Notifications (\(notifications.count))"
        //add a logic to ensure notifications.count < 20, iOS cannot handle more than that and may stop displaying them at all
        print("Notifications (\(notifications.count))")
    }
    
    func region(withNotification notification: Notification) -> CLCircularRegion {
        let region = CLCircularRegion(center: notification.coordinate, radius: notification.radius, identifier: notification.id)
        region.notifyOnEntry = (notification.eventType == .onEntry)
        region.notifyOnExit = !region.notifyOnEntry
        return region
    }
    
    func startMonitoring(notification: Notification) {
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            showAlert(withTitle:"Error", message: "This device does not fully support Türfy, some functionalities may not work correctly")
            return
        }
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            showAlert(withTitle:"Warning", message: "Please grant Türfy permission to access the device location (Always on) in order for the app to work correctly")
        }
        let region = self.region(withNotification: notification)
        locationManager.startMonitoring(for: region)
    }
    
    func stopMonitoring(notification: Notification) {
        for region in locationManager.monitoredRegions {
            guard let circularRegion = region as? CLCircularRegion, circularRegion.identifier == notification.id else { continue }
            locationManager.stopMonitoring(for: circularRegion)
        }
    }
    
}
