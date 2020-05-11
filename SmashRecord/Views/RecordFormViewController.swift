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
    @IBOutlet weak var loseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFighterView.setImage(UIImage(named: "wario"), for: .normal)
        opponentFighterView.setImage(UIImage(named: "mario"), for: .normal)
        stageView.setImage(UIImage(named: "syuutenn"), for: .normal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSelectMyFighter" {
            let destinationVC = segue.destination as! FighterImageViewController
            destinationVC.switchSettingFighterImage = "myFighter"
        } else if segue.identifier == "goToSelectOpponentFighter" {
            let destinationVC = segue.destination as! FighterImageViewController
            destinationVC.switchSettingFighterImage = "opponentFighter"
        }

    }

    
    @IBAction func myFighterPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSelectMyFighter", sender: self)
    }
    
    @IBAction func opponentFighterPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSelectOpponentFighter", sender: self)
    }
    
    @IBAction func stagePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSelectStage", sender: self)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
    }
    
    
}
