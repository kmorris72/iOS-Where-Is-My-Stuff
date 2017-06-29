//
//  LoginViewController.swift
//  WhereIsMyStuff
//
//  Created by Kipp Morris on 6/24/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private static let model = Model.getInstance()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginButtonClick(_ sender: Any) {
        let code = LoginViewController.model.loginUser(usernameEmail: email.text!, password: password.text!)
        if (code == 0) {
            AlertHelper.makeAlert(message: "Login Successful!", controller: self, handler: {(alert: UIAlertAction!) in self.performSegue(withIdentifier: "Login -> Start", sender: self)})
        } else if (code == 1) {
            AlertHelper.makeAlert(message: "Please Enter Username/Email and Password", controller: self)
        } else if (code == 2) {
            AlertHelper.makeAlert(message: "Username Not In Database", controller: self)
        } else if (code == 3) {
            AlertHelper.makeAlert(message: "Email Not In Database", controller: self)
        } else if (code == 4) {
            AlertHelper.makeAlert(message: "Username/Email Or Password Incorrect", controller: self)
        } else {
            AlertHelper.makeAlert(message: "ERROR", controller: self)
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
