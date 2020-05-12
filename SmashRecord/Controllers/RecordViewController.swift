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
    
    var records: Results<Record>?
    
    let realm = try! Realm()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadRecords()
    }
    
    //MARK: - Data Manipulation Methods
    func loadRecords() {
        records = realm.objects(Record.self)
        tableView.reloadData()
    }

}


extension RecordViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Tableview Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecordTableViewCell

        if let record = records?[indexPath.row] {
//            cell.resultLabel.text = record.result
            cell.myFighterView.image = UIImage(named: record.myFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 10))
            cell.opponentFighterView.image = UIImage(named: record.opponentFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            cell.stageView.image = UIImage(named: record.stage)
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
