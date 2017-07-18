//
//  ViewFoundItemViewController.swift
//  WhereIsMyStuff
//
//  Created by Rahul Brahmal on 7/18/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewFoundItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var foundTableView: UITableView!
    
    var listVals:[String] = []
    
    var handle:DatabaseHandle?
    
    var databaseReference:DatabaseReference?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listVals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = listVals[indexPath.row]
            return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        databaseReference = Database.database().reference()
        
//        handle = databaseReference?.child("found items").observe(.childAdded, with: { (snapshot) in
//        
//            if let item = snapshot.value as? String {
//                self.listVals.append(item)
//                self.foundTableView.reloadData()
//            }
//        
//        })
        
        handle = databaseReference?.child("found items").observe(.childAdded, with: { (snapshot) in
            
            if let item = snapshot.value as? String {
                self.listVals.append(item)
                self.foundTableView.reloadData()
            }
        })
        
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
