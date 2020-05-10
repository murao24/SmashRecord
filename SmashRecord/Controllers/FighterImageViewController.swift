//
//  FIghterImageViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class FighterImageViewController: UIViewController {
    

    @IBOutlet var fighterViews: [UIButton]!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for fighterView in fighterViews {
            fighterView.setImage(UIImage(named: S.fightersArray[count][1]), for: .normal)
            fighterView.contentMode = .scaleAspectFit
            fighterView.imageEdgeInsets = UIEdgeInsets(top: 0, left: -45, bottom: 0, right: 0)
            count += 1
        }
    }
    

}
