//
//  AnalyzeViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class AnalyzeViewController: UIViewController {
    
    let realm = try! Realm()
    
    var records: Results<Record>?
    
    @IBOutlet weak var fighterLabel: UIButton!
    @IBOutlet weak var stageLabel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        onButton(button: fighterLabel)
    }
    
    @IBAction func sortFighter(_ sender: UIButton) {
        onButton(button: fighterLabel)
        offButton(button: stageLabel)
    }
    
    @IBAction func sortStage(_ sender: UIButton) {
        onButton(button: stageLabel)
        offButton(button: fighterLabel)
    }
    
}

extension AnalyzeViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch fighterLabel.isSelected {
        case true:
            return S.fightersArray.count
        case false:
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        return cell
    }
    

}
