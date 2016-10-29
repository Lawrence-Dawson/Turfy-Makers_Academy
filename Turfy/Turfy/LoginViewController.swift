//
//  LoginViewController.swift
//  Turfy
//
//  Created by James Stonehill on 26/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // let ref = FIRDatabase.database().reference().child("user")
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    var login = FBSDKLoginManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        if (FBSDKAccessToken.current() != nil) {
            print("yeahhh")
            DispatchQueue.main.async(){ //do not ask me what is going on here
                self.performSegue(withIdentifier: "loginSegue", sender: self)

            }
            self.loginButton.isHidden = true
        } else {
        loginButton!.delegate = self
        view.addSubview(loginButton!)
        loginButton!.center = view.center
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        // Do any additional setup after loading the view.
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) { //move this to settings
       // try! FIRAuth.auth()!.signOut()
        print ("did log out of fb")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //let itemRef = self.ref.childByAutoId()
        if error != nil {
            print(error.localizedDescription)
            return
        }
        else if result.isCancelled {
            print("login cancelled")
        }
        else {
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            firebaseSignInIfNotAlready(credential: credential)
            //signedInListener()
            
        }
    }
    
    func firebaseSignInIfNotAlready(credential: FIRAuthCredential){
        if let user = FIRAuth.auth()?.currentUser {
                self.performSegue(withIdentifier: "loginSegue", sender: self)
        } else {
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            //...
            if (user != nil) {
                print ("user exists")
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
            else if (error != nil) {
                print(error?.localizedDescription)
                print("error above")
            }
            
        }
    }
    }
    
    
    func signedInListener() {
        FIRAuth.auth()?.addStateDidChangeListener() { auth, user in
            if user != nil {
                print(user)
                print ("user above")
            } else {
                print("Not signed in")
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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



