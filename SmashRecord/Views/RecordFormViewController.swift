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

    var mainFighter: Results<MainFighter>?
    
    let realm = try! Realm()
    
    @IBOutlet weak var myFighterView: UIButton!
    @IBOutlet weak var opponentFighterView: UIButton!
    @IBOutlet weak var stageView: UIButton!
    @IBOutlet weak var winButton: UIButton!
    @IBOutlet weak var loseButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    var myFighter = "mario"
    var opponentFighter = "mario"
    var stage = "syuutenn"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMainFighter()
        
        if mainFighter?.count != 0 {
            if let mainFighter = mainFighter {
                myFighter = mainFighter[0].mainFighter
            }
        }
        
        myFighterView.setImage(UIImage(named: myFighter), for: .normal)
        opponentFighterView.setImage(UIImage(named: opponentFighter), for: .normal)
        stageView.setImage(UIImage(named: stage), for: .normal)
        onButton(button: winButton)
        
        registerButton.layer.cornerRadius = 20
        
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
            onButton(button: winButton)
            offButton(button: loseButton)
        case "負け":
            onButton(button: loseButton)
            offButton(button: winButton)
        default:
            break
        }

    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        let newRecord = Record()
        newRecord.myFighter = myFighter
        newRecord.opponentFighter = opponentFighter
        newRecord.stage = stage
        newRecord.date = Date()
        if winButton.isSelected == true {
            newRecord.result = true
        } else {
            newRecord.result = false
        }

        save(record: newRecord)

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func save(record: Record) {
        do {
            try realm.write {
                realm.add(record)
            }
        } catch {
            print("Error saving record \(error)")
        }
    }
    
    func loadMainFighter() {
        mainFighter = realm.objects(MainFighter.self)
    }
    
}

extension RecordFormViewController {
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }

}

