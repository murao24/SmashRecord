//
//  ButtonSwitchController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import  UIKit

extension UIViewController {
    
    // button toggle
    func onButton(button: UIButton) {
        button.isSelected = true
        button.isEnabled = false
    }
    
    func offButton(button: UIButton) {
        button.isSelected = false
        button.isEnabled = true
    }
    
}
