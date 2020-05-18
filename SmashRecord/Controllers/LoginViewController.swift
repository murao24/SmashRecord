//
//  LoginViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/02.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class LoginViewController: UIViewController, FUIAuthDelegate {

    @IBOutlet weak var authButton: UIButton!
    
    var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}

    let providers: [FUIAuthProvider] = [
      FUIGoogleAuth(),
      FUIEmailAuth(),
      FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!),
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authUI.delegate = self
        authUI.providers = providers
        authButton.addTarget(self, action: #selector(self.authButtonPressed(sender:)), for: .touchUpInside)
    
    }

    @objc func authButtonPressed(sender: AnyObject) {

        let authViewController = self.authUI.authViewController()
        self.present(authViewController, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
      // handle user and error as necessary
        if error == nil {
            self.performSegue(withIdentifier: "loginToHome", sender: nil)
        } else {
            print("error")
        }
    }
    
    
}
