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
    var analyzeByFighters: Results<AnalyzeByFighter>?
    
    @IBOutlet weak var myFighterLabel: UIButton!
    @IBOutlet weak var versusOpponentLabel: UIButton!
    @IBOutlet weak var stageLabel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortByFighterLabel: UIButton!
    @IBOutlet weak var sortByGameCountLabel: UIButton!
    @IBOutlet weak var sortByWinCountLabel: UIButton!
    @IBOutlet weak var sortByLoseCountLabel: UIButton!
    @IBOutlet weak var sortByWinRateLabel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // button is selected
        onButton(button: myFighterLabel)
        onButton(button: sortByFighterLabel)
        
        // tableView
        loadRecord(sortedBy: "fighterID", ascending: true)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculateRecord()
        tableView.reloadData()
    }
    

    @IBAction func sortMyFighter(_ sender: UIButton) {
        onButton(button: myFighterLabel)
        offButton(button: versusOpponentLabel)
        offButton(button: stageLabel)
    }
    
    @IBAction func sortOpponentFighter(_ sender: UIButton) {
        onButton(button: versusOpponentLabel)
        offButton(button: myFighterLabel)
        offButton(button: stageLabel)
    }
    
    
    @IBAction func sortStage(_ sender: UIButton) {
        onButton(button: stageLabel)
        offButton(button: versusOpponentLabel)
        offButton(button: myFighterLabel)
    }
    
    // switch Button color
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            onButton(button: sortByFighterLabel)
            offButton(button: sortByGameCountLabel)
            offButton(button: sortByWinCountLabel)
            offButton(button: sortByLoseCountLabel)
            offButton(button: sortByWinRateLabel)
            loadRecord(sortedBy: "fighterID", ascending: true)
        case 1:
            offButton(button: sortByFighterLabel)
            onButton(button: sortByGameCountLabel)
            offButton(button: sortByWinCountLabel)
            offButton(button: sortByLoseCountLabel)
            offButton(button: sortByWinRateLabel)
            loadRecord(sortedBy: "gameCount")
        case 2:
            offButton(button: sortByFighterLabel)
            offButton(button: sortByGameCountLabel)
            onButton(button: sortByWinCountLabel)
            offButton(button: sortByLoseCountLabel)
            offButton(button: sortByWinRateLabel)
            loadRecord(sortedBy: "winCount")
        case 3:
            offButton(button: sortByFighterLabel)
            offButton(button: sortByGameCountLabel)
            offButton(button: sortByWinCountLabel)
            onButton(button: sortByLoseCountLabel)
            offButton(button: sortByWinRateLabel)
            loadRecord(sortedBy: "loseCount")
        case 4:
            offButton(button: sortByFighterLabel)
            offButton(button: sortByGameCountLabel)
            offButton(button: sortByWinCountLabel)
            offButton(button: sortByLoseCountLabel)
            onButton(button: sortByWinRateLabel)
            loadRecord(sortedBy: "winRate")
        default:
            return
        }

    }
    
    func loadRecord(sortedBy: String, ascending: Bool = false) {
        records = realm.objects(Record.self)
        analyzeByFighters = realm.objects(AnalyzeByFighter.self).sorted(byKeyPath: sortedBy, ascending: ascending)
        tableView.reloadData()
    }
    
    
    // Add database of analyzeByFighter
    func calculateRecord() {
        
        for i in 0...S.fightersArray.count - 1 {
            let game = records?.filter("myFighter == %@",S.fightersArray[i][1])
            let win = game?.filter("result = true")
            
            let newAnalyzeByFighter = AnalyzeByFighter()
            newAnalyzeByFighter.myFighter = S.fightersArray[i][1]
            if  game?.count == 0  {
                newAnalyzeByFighter.fighterID = i
                newAnalyzeByFighter.gameCount = 0
                newAnalyzeByFighter.winCount = 0
                newAnalyzeByFighter.winRate = 0
                newAnalyzeByFighter.loseCount = 0
                saveAnalyzeByFighter(analyzeByFighter: newAnalyzeByFighter)
            } else {
                
                if let game = game, let win = win {
                    newAnalyzeByFighter.fighterID = i
                    newAnalyzeByFighter.gameCount = game.count
                    newAnalyzeByFighter.winCount = win.count
                    newAnalyzeByFighter.loseCount = game.count - win.count
                    newAnalyzeByFighter.winRate = Int(CGFloat(win.count) / CGFloat(game.count) * 100)
                    
                    saveAnalyzeByFighter(analyzeByFighter: newAnalyzeByFighter)
                    
                }
            }
            
        }

    }
    
    func saveAnalyzeByFighter(analyzeByFighter: AnalyzeByFighter) {
        do {
            try realm.write {
                realm.add(analyzeByFighter, update: .modified)
            }
        } catch {
            print("Error saving calculating records \(error)")
        }
    }
    
}



extension AnalyzeViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return S.fightersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnalyzeTableViewCell
        cell.winRateLabel.adjustsFontSizeToFitWidth = true
        
        if let analyzeByFighters = analyzeByFighters?[indexPath.row] {
            
            guard analyzeByFighters.gameCount != 0 else {
                cell.fighterLabel.image = UIImage(named: analyzeByFighters.myFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
                cell.gameCountLabel.text = "-"
                cell.winCountLabel.text = "-"
                cell.loseCountLabel.text = "-"
                cell.winRateLabel.text = "-"
                return cell
            }

            cell.fighterLabel.image = UIImage(named: analyzeByFighters.myFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
            cell.gameCountLabel.text = "\(String(analyzeByFighters.gameCount))"
            cell.winCountLabel.text = "\(String(analyzeByFighters.winCount))"
            cell.loseCountLabel.text = "\(String(analyzeByFighters.loseCount))"
            cell.winRateLabel.text = "\(String(analyzeByFighters.winRate))%"
        }

        
        return cell
    }
    
    // MARK: - Tableview Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
