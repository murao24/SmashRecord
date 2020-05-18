//
//  RelayingViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/18.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class RelayingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withIdentifier: "goToHome", sender: nil)
    }
    
}
