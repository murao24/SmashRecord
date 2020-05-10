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
    private var count = 0
    var myFighterName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Show fighterImage
        for fighterView in fighterViews {
            fighterView.setImage(UIImage(named: S.fightersArray[count][1]), for: .normal)
            fighterView.contentMode = .scaleAspectFit
            fighterView.imageEdgeInsets = UIEdgeInsets(top: 2, left: -45, bottom: 2, right: 2)
            count += 1
        }
        
    }
    
    @IBAction func fighterPressed(_ sender: UIButton) {
        
        print(sender.currentImage)
        
    }
    
}
