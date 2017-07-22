//
//  EnterFoundItemViewController.swift
//  WhereIsMyStuff
//
//  Created by Kipp Morris on 6/29/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class EnterFoundItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {
    
    private static let model = Model.getInstance()
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemTypePicker: UIPickerView!
    @IBOutlet weak var itemDescription: UITextView!
    
    @IBOutlet weak var map: MKMapView!
    var currentItemLocation: CLLocationCoordinate2D!
    
    let manager = CLLocationManager()
    
    var pickerData: [Model.ItemType] = []
    var pickerType: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.itemTypePicker.delegate = self
        self.itemTypePicker.dataSource = self
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationOnLongPress(gesture:)))
        
        gestureRecognizer.minimumPressDuration = 1.0
        self.map.addGestureRecognizer(gestureRecognizer)
        
        for type in EnterFoundItemViewController.model.getItemTypes() {
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.20, 0.20)
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        map.setRegion(region, animated:true)
        
        self.map.showsUserLocation = true
    }
    
    func addAnnotationOnLongPress(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .ended {
            let point = gesture.location(in: self.map)
            let coordinate = self.map.convert(point, toCoordinateFrom: self.map)
            currentItemLocation = coordinate
            print (coordinate)
            var annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Found Item Location"
            annotation.subtitle = "Location of Found Item"
            self.map.addAnnotation(annotation)
        }
    }
    
    @IBAction func onEnterButtonClick(_ sender: Any) {
        EnterFoundItemViewController.model.addFoundItem(name: itemName.text!, type: pickerType, description: itemDescription.text!, user: EnterFoundItemViewController.model.getCurrentUser(), location: currentItemLocation)
        AlertHelper.makeAlert(message: "Item Successfully Added!", controller: self, handler: {(alert: UIAlertAction!) in self.performSegue(withIdentifier: "EnterFoundItem->Welcome", sender: self)})
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
