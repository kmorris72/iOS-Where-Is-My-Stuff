//
//  AlertHelper.swift
//  WhereIsMyStuff
//
//  Created by Kipp Morris on 6/29/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit

class AlertHelper {
    
    static func makeAlert(message: String, controller: UIViewController, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(alertAction)
        controller.present(alert, animated: true, completion: nil)
    }
}
