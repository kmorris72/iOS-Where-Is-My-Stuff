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
    
//    var latVals:[Double] = []
//    var longVals:[Double] = []
    
    var manager:CLLocationManager!
    
    var handle:DatabaseHandle?
    
    var dbLostItemsRef:DatabaseReference?
    var dbFoundItemsRef:DatabaseReference?
    
    var dbInnerLostRef:DatabaseReference?
    
    let annotation = MKPointAnnotation()
    
    
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
                            
                            for innerItems in snapshotInnerLost.children.allObjects as![DataSnapshot] {
                                
                                let obj = innerItems.value as? [String: Any]
                                let lat = obj?["latitude"] as? String
                                let long = obj?["longitude"] as? String
                                
//                                let lat = innerItems.value?["latitude"] as? Double
//                                let long = innerItems.value?["longitude"] as Double
                                
                                print ("Lat: \(lat)")
                                print ("Long: \(long)")
                            }
                            
                        })
                    }
                    
                    
                    
//                    let latObjLost = obj?["latitude"] as? Double
//                    let longObjLost = obj?["longitude"] as? Double
//                    
                    
//                    self.latVals.append(latObjLost!) //Maybe try and plot points directly
//                    self.longVals.append(longObjLost!)
                    
                    
//                    self.annotation.coordinate = CLLocationCoordinate2D(latitude: latObjLost!, longitude: longObjLost!)
//                    
//                    self.map.addAnnotation(self.annotation)
//                    
                }
            }
        })
        
        dbFoundItemsRef?.observe(DataEventType.value, with :{(snapshotFound) in
            
            if (snapshotFound.childrenCount > 0) {
                
                for items in snapshotFound.children.allObjects as![DataSnapshot] {
                    
                    let obj = items.value as? [String: AnyObject]
                    let name = obj?["name"] as? String
                    print (name)
//                    
//                    let latObjFound = obj?["latLng"] as? Double
//                    let longObjFound = obj?["latLng"] as? Double
//                    
                    
//                    self.latVals.append(latObjFound!)
//                    self.longVals.append(longObjFound!)
                    
                    
//                    self.annotation.coordinate = CLLocationCoordinate2D(latitude: latObjFound!,longitude: longObjFound!)
//                    
//                    self.map.addAnnotation(self.annotation)
                    
                }
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.map.showsUserLocation = true
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
