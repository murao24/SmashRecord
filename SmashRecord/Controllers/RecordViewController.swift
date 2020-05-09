//
//  SecondViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/02.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class RecordViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stageLabel: UILabel!
    
    var records: Results<Record>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        stageLabel.adjustsFontSizeToFitWidth = true
    }

}


extension RecordViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Tableview Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecordTableViewCell

        if let record = records?[indexPath.row] {
//            cell.resultLabel.text = record.result
            cell.myFighterView.image = UIImage(named: record.myFighter)
            cell.opponentFighterView.image = UIImage(named: record.opponentFighter)
            cell.stageLabel.text = record.stage
        }
        
        return cell
    }
    
    func addButtonPressed(message: String) {
        


    }
    
}
