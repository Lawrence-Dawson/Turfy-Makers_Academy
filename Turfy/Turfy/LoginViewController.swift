//
//  LoginViewController.swift
//  Turfy
//
//  Created by James Stonehill on 26/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookLogin
import FBSDKShareKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookLogin (sender: AnyObject){
        let facebookLogin = FBSDKLoginManager()
        print("Logging In")
        facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler:{(facebookResult, facebookError) -> Void in
            if facebookError != nil { print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult!.isCancelled { print("Facebook login was cancelled.")
            } else { print("You’re inz ;)")}
        });
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
