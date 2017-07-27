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
    
    private let model = Model.getInstance()

    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var textDisplay: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var handle:DatabaseHandle?
    
    private let lostItemsDatabase = Database.database().reference().child("lost items")
    private let foundItemsDatabase = Database.database().reference().child("found items")

    private var pickerData = ["Lost Item", "Found Item"]
    
    private var lost_item = true
    
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
        
        if (pickerData[row] == "Lost Item") {
            lost_item = true
        } else {
            lost_item = false
        }
        
    }
    
    @IBAction func onSearchButtonClick(_ sender: Any) {
        lostItemsDatabase.observe(DataEventType.value, with :{ (snapshot) in
            if (snapshot.hasChildren()) {
                for itemSnap in snapshot.children.allObjects as! [DataSnapshot] {
                    let itemToAdd = DatabaseHelper.parseItem(itemSnap: itemSnap)
                    self.model.addItem(item: itemToAdd, foundItem: !self.lost_item)
                    
//                    let obj = items.value as? [String: AnyObject]
//                    let name = obj?["name"] as? String
//                    if (name?.lowercased() == self.textFromField.lowercased()) {
//                        let searchOne = obj?["searchDescription"] as? String
//                        if let searchVal = searchOne {
//                            self.textDisplay.text = searchVal
//                            break
//                        }
//                    } else {
//                        let searchVal = "No Results"
//                        self.textDisplay.text = searchVal
//                    }
                }
            }
        })
        
        foundItemsDatabase.observe(DataEventType.value, with :{ (snapshot) in
            if (snapshot.hasChildren()) {
                for itemSnap in snapshot.children.allObjects as! [DataSnapshot] {
                    let itemToAdd = DatabaseHelper.parseItem(itemSnap: itemSnap)
                    self.model.addItem(item: itemToAdd, foundItem: !self.lost_item)
                    
                    //                    let obj = items.value as? [String: AnyObject]
                    //                    let name = obj?["name"] as? String
                    //                    if (name?.lowercased() == self.textFromField.lowercased()) {
                    //                        let searchOne = obj?["searchDescription"] as? String
                    //                        if let searchVal = searchOne {
                    //                            self.textDisplay.text = searchVal
                    //                            break
                    //                        }
                    //                    } else {
                    //                        let searchVal = "No Results"
                    //                        self.textDisplay.text = searchVal
                    //                    }
                }
            }
        })
        
        if (model.searchFound(foundItem: !lost_item, name: itemName.text!)) {
            let itemText: String
            if (!lost_item) {
                itemText = "FOUND ITEM\n"
            } else {
                itemText = "LOST ITEM\n"
            }
            let srchDescription = itemText + model.searchResult(foundItem: !lost_item, name: itemName.text!)
            self.textDisplay.text = srchDescription
        } else {
            self.textDisplay.text = "No Results"
        }
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
