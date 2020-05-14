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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        loadRecord()
        onButton(button: fighterLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @IBAction func sortFighter(_ sender: UIButton) {
        onButton(button: fighterLabel)
        offButton(button: stageLabel)
    }
    
    @IBAction func sortStage(_ sender: UIButton) {
        onButton(button: stageLabel)
        offButton(button: fighterLabel)
    }
    
    func loadRecord() {
        records = realm.objects(Record.self)
    }
    
}



extension AnalyzeViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch fighterLabel.isSelected {
        case true:
            return S.fightersArray.count
        case false:
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnalyzeTableViewCell
        
        // キャラ別
        let game = records?.filter("myFighter == %@",S.fightersArray[indexPath.row][1])
        let win = game?.filter("result = true")

        cell.fighterLabel.image = UIImage(named: S.fightersArray[indexPath.row][1])?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
            
        guard game?.count != 0 else {
            cell.gameCountLabel.text = "-"
            cell.winCountLabel.text = "-"
            cell.loseCountLabel.text = "-"
            cell.winRateLabel.text = "-"
            return cell
        }
        
        if let game = game, let win = win {
            
            let loseCount = game.count - win.count
            let winRate = Int(CGFloat(win.count) / CGFloat(game.count) * 100)
            
            cell.gameCountLabel.text = "\(game.count)"
            cell.winCountLabel.text = "\(win.count)"
            cell.loseCountLabel.text = "\(loseCount)"
            cell.winRateLabel.text = "\(winRate)%"
            cell.winRateLabel.adjustsFontSizeToFitWidth = true
        }
        
        return cell
    }
    
    // MARK: - Tableview Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
