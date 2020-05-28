//
//  AccountViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/02.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class AccountViewController: AnalyzeViewController {
    
    var mainFighter = ""
    
    @IBOutlet weak var fighterButton: UIButton!
    
    @IBOutlet weak var gameCountLabel: UILabel!
    @IBOutlet weak var winCountLabel: UILabel!
    @IBOutlet weak var loseCountLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func mainFighterPressed(_ sender: Any) {
        let fighterImageVC = storyboard?.instantiateViewController(identifier: "FIghterImageViewController") as! FighterImageViewController
        fighterImageVC.switchSettingFighterImage = "mainFighter"
        self.present(fighterImageVC, animated: true, completion: nil)
    }

    
}
