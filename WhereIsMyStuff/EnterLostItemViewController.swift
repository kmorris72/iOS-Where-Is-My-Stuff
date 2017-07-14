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
    
    
    let manager = CLLocationManager()
    
    var pickerData: [Model.ItemType] = []
    var pickerType: Int = 0
    
    let regionRadius: CLLocationDistance = 200
    
    var userLat: Double = 33.748995
    var userLong: Double = -84.387982
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.itemTypePicker.delegate = self
        self.itemTypePicker.dataSource = self
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
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
