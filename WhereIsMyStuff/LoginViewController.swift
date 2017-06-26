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
        let alert: UIAlertController
        if (code == 0) {
            alert = UIAlertController(title: nil, message: "Login Successful!", preferredStyle: UIAlertControllerStyle.alert)
        } else if (code == 1) {
            alert = UIAlertController(title: nil, message: "Please Enter Username/Email and Password", preferredStyle: UIAlertControllerStyle.alert)
        } else if (code == 2) {
            alert = UIAlertController(title: nil, message: "Username Not In Database", preferredStyle: UIAlertControllerStyle.alert)
        } else if (code == 3) {
            alert = UIAlertController(title: nil, message: "Email Not In Database", preferredStyle: UIAlertControllerStyle.alert)
        } else if (code == 4) {
            alert = UIAlertController(title: nil, message: "Username/Email Or Password Incorrect", preferredStyle: UIAlertControllerStyle.alert)
        } else {
            alert = UIAlertController(title: nil, message: "ERROR", preferredStyle: UIAlertControllerStyle.alert)
        }
        present(alert, animated: true, completion: nil)
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
