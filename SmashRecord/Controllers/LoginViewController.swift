//
//  LoginViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/02.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.addBorderAll(color: .black)
        passwordTextField.addBorderAll(color: .black)
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        

    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
}
