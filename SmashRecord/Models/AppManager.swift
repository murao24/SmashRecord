//
//  AppManager.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/18.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import Firebase

class AppManager {
    
    static let shared = AppManager()
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var appContainer: AppContainerViewController!
    
    private init() {}
    
    func showApp() {
        
        var viewController: UIViewController
        
        if Auth.auth().currentUser == nil {
            viewController = storyBoard.instantiateViewController(identifier: "LoginViewController")
            
        } else {
            viewController = storyBoard.instantiateViewController(identifier: "MainViewContoller")
        }
        
        appContainer.present(viewController, animated: true, completion: nil)
        
    }
    
    func logout(){
        try! Auth.auth().signOut()
        appContainer.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
}
