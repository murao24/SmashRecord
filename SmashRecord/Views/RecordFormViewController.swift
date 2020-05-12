//
//  RecordFormViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class RecordFormViewController: UIViewController {
    
    var records: Results<Record>?
    
    let realm = try! Realm()
    
    @IBOutlet weak var myFighterView: UIButton!
    @IBOutlet weak var opponentFighterView: UIButton!
    @IBOutlet weak var stageView: UIButton!
    @IBOutlet weak var winButton: UIButton!
    @IBOutlet weak var loseButton: UIButton!
    
    var myFighter = "wario"
    var opponentFighter = "mario"
    var stage = "syuutenn"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFighterView.setImage(UIImage(named: myFighter), for: .normal)
        opponentFighterView.setImage(UIImage(named: opponentFighter), for: .normal)
        stageView.setImage(UIImage(named: stage), for: .normal)
        
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
    
    @IBAction func resultPressed(_ sender: UIButton) {
        
        let result = sender.currentTitle
        
        switch result {
        case "勝ち":
            winButton.backgroundColor = UIColor(red: 29 / 255, green: 161 / 255, blue: 242 / 255, alpha: 1)
            loseButton.backgroundColor = UIColor.black
        case "負け":
            loseButton.backgroundColor = UIColor(red: 29 / 255, green: 161 / 255, blue: 242 / 255, alpha: 1)
            winButton.backgroundColor = UIColor.black
        default:
            print("Error tapping win or lose.")
        }

    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        let newRecord = Record()
        newRecord.myFighter = myFighter
        newRecord.opponentFighter = opponentFighter
        newRecord.stage = stage
        save(record: newRecord)

    }
    
    func save(record: Record) {
        
        do {
            try realm.write {
                realm.add(record)
            }
            dismiss(animated: true, completion: nil)
        } catch {
            print("Error saving record \(error)")
        }

    }
    
    
}
