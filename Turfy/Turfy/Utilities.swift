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
        let topController = topMostController()
        alert.addAction(action)
        topController.present(alert, animated: true, completion: nil)
    }
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
}
