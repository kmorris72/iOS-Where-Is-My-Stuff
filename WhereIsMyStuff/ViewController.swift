//
//  ViewController.swift
//  WhereIsMyStuff
//
//  Created by Kipp Morris on 6/15/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var sampleButton: UIButton!

    @IBAction func clicked(_ sender: Any) {
        if let title = sampleButton.currentTitle {
            if title == "Sample" {
                sampleButton.setTitle("Clicked!", for: UIControlState.normal)
            }
        }
    }
}

