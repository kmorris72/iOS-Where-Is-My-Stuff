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

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var manager:CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
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
