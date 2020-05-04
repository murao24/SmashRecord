//
//  FighterViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class FighterViewController: UIViewController {
    
    let realm = try! Realm()
    
    var fighterNotes: Results<FighterNote>?
    
    var selectedFighter: Fighter?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(selectedFighter?.fighterName)
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
    }
    


}
