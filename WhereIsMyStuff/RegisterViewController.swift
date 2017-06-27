//
//  RegisterViewController.swift
//  WhereIsMyStuff
//
//  Created by Kipp Morris on 6/27/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private static let model = Model.getInstance()
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password1: UITextField!
    @IBOutlet weak var password2: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var _adminSwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onRegisterButtonClick(_ sender: Any) {
        let thing = RegisterViewController.model.addUser(firstName: firstName.text, lastName: lastName.text, email: email.text, username: username.text, password1: password1.text, password2: password2.text, isAdmin: _adminSwitch.isOn)
    }
    
}
