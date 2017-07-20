//
//  SearchItemsViewController.swift
//  WhereIsMyStuff
//
//  Created by Rahul Brahmal on 7/19/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchItemsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var textDisplay: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var handle:DatabaseHandle?
    var dbRef:DatabaseReference?
    
    var pickerData = ["Lost Item", "Found Item"]
    
    var lost_item = true
    
    var textFromField = ""
    
    var searchDescription = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
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
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerData[row] == "Lost Items") {
            lost_item = true
        } else {
            lost_item = false
        }
        
    }
    
    @IBAction func onSearchButtonClick(_ sender: Any) {
        
        textDisplay.text = "Enter button has been selected."
        
        if (lost_item) {
            dbRef = Database.database().reference().child("lost items")
        } else {
            dbRef = Database.database().reference().child("found items")
        }
        
        dbRef?.observe(DataEventType.value, with :{(snapshot) in
            
            if (snapshot.childrenCount > 0) {
                
                for items in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let obj = items.value as? [String: AnyObject]
                    let name = obj?["name"] as? String
                    
                    if (name?.lowercased() == self.textFromField.lowercased()) {
                        self.searchDescription = (obj?["searchDescription"] as? String)!
                    } else {
                        self.searchDescription = ""
                    }
                }
            }
        })
        
        textDisplay.text = searchDescription
    }
    
    
    @IBAction func getText(_ sender: Any) {
        textFromField = itemName.text!
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
