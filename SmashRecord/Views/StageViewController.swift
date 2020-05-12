//
//  StageViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/11.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class StageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func stagePressed(_ sender: UIButton) {
        
        let num = sender.tag
        let stageName = S.stageArray[num]
        
        let preVC = self.presentingViewController as! RecordFormViewController
        preVC.stageView.setImage(UIImage(named: stageName), for: .normal)
        preVC.stage = stageName
        dismiss(animated: true, completion: nil)

    }
    


}
