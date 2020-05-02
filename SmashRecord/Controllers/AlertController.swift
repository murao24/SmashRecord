//
//  AlertController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/02.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func okAlert(title: String?, message: String?, okHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: okHandler))
        return alert
    }
    
    static func errorAlert(title: String? = "⚠️", message: String?, error: Error, okHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .destructive, handler: okHandler))
        return alert
    }
 
}


extension UIViewController {
    
    func present(alert: UIAlertController, completion: (() -> Void)? = nil) {
        present(alert,animated: true, completion: completion)
    }

}
