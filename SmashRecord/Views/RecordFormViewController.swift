//
//  RecordFormViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class RecordFormViewController: UIViewController {
    
    @IBOutlet weak var myFighterView: UIButton!
    @IBOutlet weak var opponentFighterView: UIButton!
    @IBOutlet weak var stageView: UIButton!
    @IBOutlet weak var winButton: UIButton!
    @IBOutlet weak var drawButton: UIButton!
    @IBOutlet weak var loseButton: UIButton!
    
    let buttonImage = UIImage(named: "mario")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFighterView.setImage(buttonImage, for: .normal)
        
    }
    
    @IBAction func myFighterPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSelectFighter", sender: self)
    }
    
    @IBAction func opponentFighterPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSelectOpponentFighter", sender: self)
    }
    
    @IBAction func stagePressed(_ sender: UIButton) {
    }
    
}
