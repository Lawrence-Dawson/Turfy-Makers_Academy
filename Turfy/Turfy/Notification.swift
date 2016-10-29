//
//  Notification.swift
//  Turfy
//
//  Created by Johnny Dworzynski on 29/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import Foundation

import UIKit
import MapKit
import CoreLocation

struct GeoKey {
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let radius = "radius"
    static let id = "id"
    static let sender = "sender"
    static let text = "message"
    static let eventType = "eventType"
}

enum EventType: String {
    case onEntry = "On Entry"
    case onExit = "On Exit"
}

class Notification: NSObject, NSCoding, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var id: String
    var sender: String
    var message: String
    var eventType: EventType
    
    var title: String? {
        if message.isEmpty {
            return "No Message"
        }
        return message
    }
    
    var subtitle: String? {
        let eventTypeString = eventType.rawValue
        return "Radius: \(radius)m - \(eventTypeString)"
    }
    
    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, sender: String, message: String, eventType: EventType) {
        self.coordinate = coordinate
        self.radius = radius
        self.id = identifier
        self.sender = sender
        self.message = message
        self.eventType = eventType
    }
    
    // MARK: NSCoding
    required init?(coder decoder: NSCoder) {
        let latitude = decoder.decodeDouble(forKey: GeoKey.latitude)
        let longitude = decoder.decodeDouble(forKey: GeoKey.longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        radius = decoder.decodeDouble(forKey: GeoKey.radius)
        id = decoder.decodeObject(forKey: GeoKey.id) as! String
        sender = decoder.decodeObject(forKey: GeoKey.sender) as! String
        message = decoder.decodeObject(forKey: GeoKey.text) as! String
        eventType = EventType(rawValue: decoder.decodeObject(forKey: GeoKey.eventType) as! String)!
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(coordinate.latitude, forKey: GeoKey.latitude)
        coder.encode(coordinate.longitude, forKey: GeoKey.longitude)
        coder.encode(radius, forKey: GeoKey.radius)
        coder.encode(id, forKey: GeoKey.id)
        coder.encode(sender, forKey: GeoKey.sender)
        coder.encode(message, forKey: GeoKey.text)
        coder.encode(eventType.rawValue, forKey: GeoKey.eventType)
    }

    
}
