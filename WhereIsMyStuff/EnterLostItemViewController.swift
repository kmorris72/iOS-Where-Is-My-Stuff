//
//  EnterLostItemViewController.swift
//  WhereIsMyStuff
//
//  Created by Kipp Morris on 6/29/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit

class EnterLostItemViewController: UIViewController {
    
    private static let model = Model.getInstance()
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemType: UIPickerView!
    @IBOutlet weak var itemDescription: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEnterButtonClick(_ sender: Any) {
        // implement
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
