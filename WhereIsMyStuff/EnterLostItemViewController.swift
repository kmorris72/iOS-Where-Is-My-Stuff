//
//  EnterLostItemViewController.swift
//  WhereIsMyStuff
//
//  Created by Rahul V Brahmal on 7/11/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit
import MapKit

class EnterLostItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private static let model = Model.getInstance()
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemTypePicker: UIPickerView!
    @IBOutlet weak var itemDescription: UITextView!
    
    var pickerData: [Model.ItemType] = []
    var pickerType: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.itemTypePicker.delegate = self
        self.itemTypePicker.dataSource = self
        
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
