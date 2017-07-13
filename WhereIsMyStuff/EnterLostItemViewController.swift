//
//  EnterLostItemViewController.swift
//  WhereIsMyStuff
//
//  Created by Rahul V Brahmal on 7/11/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class EnterLostItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate {
    
    private static let model = Model.getInstance()
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemTypePicker: UIPickerView!
    @IBOutlet weak var itemDescription: UITextView!
    
    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    
    var pickerData: [Model.ItemType] = []
    var pickerType: Int = 0
    
    let regionRadius: CLLocationDistance = 200
    
    var userLat: Double = 0.0
    var userLong: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.itemTypePicker.delegate = self
//        self.itemTypePicker.dataSource = self
//        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        map.delegate = self
        map.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self

        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.startUpdatingLocation()
        }
        
//        let noLocation = CLLocationCoordinate2D()
//        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 50000, 50000)
//        map.setRegion(viewRegion, animated: false)
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        let currentLocation = CLLocation(latitude: userLat, longitude: userLong)
        
        centerMapOnLocation(location: currentLocation)
        
        for type in EnterLostItemViewController.model.getItemTypes() {
            pickerData.append(type)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerType = row
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]) {
        
//        let location = locations.last as! CLLocation
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//        region.center = map.userLocation.coordinate
//        map.setRegion(region, animated: true)
        
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        userLat = locValue.latitude
        userLong = locValue.longitude
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        print("Error while updating location " + error.localizedDescription)
    }
    
    func locationManagerDIdPauseLocationUpdates(manager: CLLocationManager!) {
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    @IBAction func onEnterButtonClick(_ sender: Any) {
//        let code = EnterLostItemViewController.model.addLostItem(name: itemName.text!, typePosition: pickerType, description: itemDescription.text!, user: EnterLostItemViewController.model.getCurrentUser())
//        if (code == 0) {
//            AlertHelper.makeAlert(message: "Item Successfully Added!", controller: self)
//        } else if (code == 1) {
//            AlertHelper.makeAlert(message: "Please Enter the Item Name, Select The Location and Enter the Item Description", controller: self);
//        } else {
//            AlertHelper.makeAlert(message: "ERROR", controller: self)
//        }
        EnterLostItemViewController.model.addLostItem(name: itemName.text!, typePosition: pickerType, description: itemDescription.text!, user: EnterLostItemViewController.model.getCurrentUser())
        AlertHelper.makeAlert(message: "Item Successfully Added!", controller: self, handler: {(alert: UIAlertAction!) in self.performSegue(withIdentifier: "EnterLostItem->Welcome", sender: self)})
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
