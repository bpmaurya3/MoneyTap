//
//  Helper.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/24/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import UIKit

class Helper {
    class func showAlert(message: String, title: String) {
        guard let rootController = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        rootController.present(alert, animated: true, completion: nil)
    }
    
}
