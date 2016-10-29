//
//  Utilities.swift
//  Turfy
//
//  Created by dev on 29/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit

//Helper Extensions
extension UIViewController {
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
