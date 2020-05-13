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
    @IBOutlet weak var stageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        stageLabel.adjustsFontSizeToFitWidth = true
        loadRecords()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Data Manipulation Methods
    func loadRecords() {
        records = realm.objects(Record.self).sorted(byKeyPath: "date", ascending: false)
        tableView.reloadData()
    }
    
    func delete(at indexPath: IndexPath) {
        if let record = self.records?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(record)
                }
            } catch {
                print("Error deleting record \(error)")
            }
        }
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
            if record.result == true {
                cell.resultLabel.text = "勝ち"
            } else {
                cell.resultLabel.text = "負け"
            }
            cell.myFighterView.image = UIImage(named: record.myFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0))
            cell.opponentFighterView.image = UIImage(named: record.opponentFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            cell.stageView.image = UIImage(named: record.stage)
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.delete(at: indexPath)
            self.tableView.reloadData()
            completionHandler(true)
        }
        action.image = UIImage(named: "delete-icon")
        action.backgroundColor = .red
        let configulation = UISwipeActionsConfiguration(actions: [action])
        
        return configulation

    }
    
    
}
