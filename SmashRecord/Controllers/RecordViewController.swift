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
    
    var records: Results<Record>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

}


extension RecordViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Tableview Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecordTableViewCell
        cell.resultLabel.text = "◯"
        cell.myFighterView.image = UIImage(named: S.fightersArray[10][1])
        cell.opponentFighterView.image = UIImage(named: S.fightersArray[29][1])
        cell.stageLabel.text = "ポケスタ2"
        
        return cell
    }
    
}
