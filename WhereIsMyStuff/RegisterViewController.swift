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
        let code = RegisterViewController.model.addUser(firstName: firstName.text, lastName: lastName.text, email: email.text, username: username.text, password1: password1.text, password2: password2.text, isAdmin: _adminSwitch.isOn)
        if (code == 0) {
            AlertHelper.makeAlert(message: "User Added!", controller: self, handler: {(alert: UIAlertAction!) in self.performSegue(withIdentifier: "Register->Welcome", sender: self)})
            // intent code remember
        } else if (code == 1) {
            AlertHelper.makeAlert(message: "Name Invalid", controller: self)
        } else if (code == 2) {
            AlertHelper.makeAlert(message: "Email Invalid", controller: self)
        } else if (code == 3) {
            AlertHelper.makeAlert(message: "Username Invalid", controller: self)
        } else if (code == 4) {
            AlertHelper.makeAlert(message: "Username Cannot Contain Whitespace Characters", controller: self)
        } else if (code == 5) {
            AlertHelper.makeAlert(message: "Username Cannot Contain '@' Character", controller: self)
        }  else if (code == 6) {
            AlertHelper.makeAlert(message: "Password Invalid", controller: self)
        } else if (code == 7) {
            AlertHelper.makeAlert(message: "Passwords Do Not Match", controller: self)
        } else if (code == 8) {
            AlertHelper.makeAlert(message: "Email Already In Database", controller: self)
        } else if (code == 9) {
            AlertHelper.makeAlert(message: "Username Alerady In Database", controller: self)
        } else {
            AlertHelper.makeAlert(message: "User Not Added", controller: self)
        }
    }
    
}
