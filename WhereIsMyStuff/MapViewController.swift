//
//  MapViewController.swift
//  WhereIsMyStuff
//
//  Created by Rahul Brahmal on 7/19/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var latVals:[Double] = []
    var longVals:[Double] = []
    
    var manager:CLLocationManager!
    
    var handle:DatabaseHandle?
    
    var dbLostItemsRef:DatabaseReference?
    var dbFoundItemsRef:DatabaseReference?
    
    var dbInnerLostRef:DatabaseReference?
    var dbInnerFoundRef:DatabaseReference?
    
//    let annotation = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        dbLostItemsRef = Database.database().reference().child("lost items")
        dbFoundItemsRef = Database.database().reference().child("found items")
        
        dbLostItemsRef?.observe(DataEventType.value, with :{(snapshotLost) in
            
            if (snapshotLost.childrenCount > 0) {
                
                for items in snapshotLost.children.allObjects as![DataSnapshot] {
                    
                    let obj = items.value as? [String: AnyObject]
                    let name = obj?["name"] as? String
                    if let textName = name {
                        print (textName)
                        self.dbInnerLostRef = Database.database().reference().child("lost items").child(textName).child("latLng")
                        
                        self.dbInnerLostRef?.observe(DataEventType.value, with :{(snapshotInnerLost) in
                            var i = 0
                            for innerItems in snapshotInnerLost.children.allObjects as![DataSnapshot] {
                                
                                let obj = innerItems.value as! NSNumber
                                
                                if (i == 0) {
                                    self.latVals.append(Double(obj))
                                    print ("Lat: \(obj)")
                                    i = 1
                                } else {
                                    self.longVals.append(Double(obj))
                                    print ("Long: \(obj)")
                                    i = 0
                                }
                            }
                            var j = 0
                            while (j < self.latVals.count) {
                                
                                let annotation = MKPointAnnotation()
                                
                                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(self.latVals[j]), longitude: Double(self.longVals[j]))
                                
                                self.map.addAnnotation(annotation)
                                
                                j = j + 1
                            }
                        })
                    }
                }
            }
        })
        
        dbFoundItemsRef?.observe(DataEventType.value, with :{(snapshotFound) in
            
            if (snapshotFound.childrenCount > 0) {
                
                for items in snapshotFound.children.allObjects as![DataSnapshot] {
                    
                    let obj = items.value as? [String: AnyObject]
                    let name = obj?["name"] as? String
                    if let textName = name {
                        print (textName)
                        self.dbInnerFoundRef = Database.database().reference().child("found items").child(textName).child("latLng")
                        self.dbInnerLostRef?.observe(DataEventType.value, with :{(snapshotInnerLost) in
                            var i = 0
                            for innerItems in snapshotInnerLost.children.allObjects as![DataSnapshot] {
                                
                                let obj = innerItems.value as! NSNumber
                                
                                if (i == 0) {
                                    self.latVals.append(Double(obj))
                                    print (Double(obj))
                                    i = 1
                                } else {
                                    self.longVals.append(Double(obj))
                                    print (Double(obj))
                                    i = 0
                                }
                            }
                            var j = 0
                            while (j < self.latVals.count) {
                                
                                let annotation = MKPointAnnotation()
                                
                                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(self.latVals[j]), longitude: Double(self.longVals[j]))
                                
                                self.map.addAnnotation(annotation)
                                
                                j = j + 1
                            }
                        })
                    }
                }
            }
            
        })
        
        map.showsUserLocation = true
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
