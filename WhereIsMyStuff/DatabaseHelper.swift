//
//  DatabaseHelper.swift
//  WhereIsMyStuff
//
//  Created by Kipp Morris on 7/17/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class DatabaseHelper {
    
    static func parseUser(userSnap: DataSnapshot) -> Model.User {
        let firstName = userSnap.childSnapshot(forPath: "firstName").value as! String
        let lastName = userSnap.childSnapshot(forPath: "lastName").value as! String
        let email = userSnap.childSnapshot(forPath: "email").value as! String
        let username = userSnap.childSnapshot(forPath: "username").value as! String
        let password = userSnap.childSnapshot(forPath: "password").value as! String
        let isAdmin = userSnap.childSnapshot(forPath: "isAdmin").value as! Bool
        return Model.User(firstName: firstName, lastName: lastName, email: email, username: username, password:password, isAdmin: isAdmin)
    }
    
    static func parseItem(itemSnap: DataSnapshot) -> Model.Item {
        let name = itemSnap.childSnapshot(forPath: "name").value as! String
        let type = Model.ItemType(rawValue: itemSnap.childSnapshot(forPath: "type").value as! String)!
        let description = itemSnap.childSnapshot(forPath: "description").value as! String
        let userSnap = itemSnap.childSnapshot(forPath: "user")
        let user = self.parseUser(userSnap: userSnap)
        let locationSnap = itemSnap.childSnapshot(forPath: "latLng")
        let latSnap = locationSnap.childSnapshot(forPath: "latitude")
        let longSnap = locationSnap.childSnapshot(forPath: "longitude")
        let location = CLLocationCoordinate2D(latitude: latSnap.value as! CLLocationDegrees, longitude: longSnap.value as! CLLocationDegrees)
        return Model.Item(name: name, type: type, description: description, user: user, location: location)
    }
}
