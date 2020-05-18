//
//  AppContainerViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/18.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class AppContainerViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppManager.shared.appContainer = self
        AppManager.shared.showApp()
        
    }
    
    
    

}
