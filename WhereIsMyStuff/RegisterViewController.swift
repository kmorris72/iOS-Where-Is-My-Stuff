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
            let alert = UIAlertController(title: nil, message: "User Added!", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in self.performSegue(withIdentifier: "Register -> Welcome", sender: self)})
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            // intent code remember
        } else if (code == 1) {
            let alert = UIAlertController(title: nil, message: "Name Invalid", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else if (code == 2) {
            let alert = UIAlertController(title: nil, message: "Email Invalid", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else if (code == 3) {
            let alert = UIAlertController(title: nil, message: "Username Invalid", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else if (code == 4) {
            let alert = UIAlertController(title: nil, message: "Username Cannot Contain Whitespace Characters", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else if (code == 5) {
            let alert = UIAlertController(title: nil, message: "Username Cannot Contain '@' Character", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }  else if (code == 6) {
            let alert = UIAlertController(title: nil, message: "Password Invalid", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else if (code == 7) {
            let alert = UIAlertController(title: nil, message: "Passwords Do Not Match", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else if (code == 8) {
            let alert = UIAlertController(title: nil, message: "Email Already In Database", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else if (code == 9) {
            let alert = UIAlertController(title: nil, message: "Username Alerady In Database", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: "User NOT Added", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }

    }
    
}
