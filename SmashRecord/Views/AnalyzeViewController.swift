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
    var analyzeByOpponentFighters: Results<AnalyzeByOpponentFighter>?
    var analyzeByStages: Results<AnalyzeByStage>?
    
    // 一番上
    @IBOutlet weak var myFighterLabel: UIButton!
    @IBOutlet weak var versusOpponentLabel: UIButton!
    @IBOutlet weak var stageLabel: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // その下
    @IBOutlet weak var sortByFighterLabel: UIButton!
    @IBOutlet weak var sortByGameCountLabel: UIButton!
    @IBOutlet weak var sortByWinCountLabel: UIButton!
    @IBOutlet weak var sortByLoseCountLabel: UIButton!
    @IBOutlet weak var sortByWinRateLabel: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        sortByFighterLabel.titleLabel?.adjustsFontSizeToFitWidth = true
        
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
    
    

    @IBAction func myFighterPressed(_ sender: UIButton) {
        onButton(button: myFighterLabel)
        offButton(button: versusOpponentLabel)
        offButton(button: stageLabel)
        sortByFighterLabel.setTitle("自分", for: .normal)
        tableView.reloadData()
    }
    
    @IBAction func opponentFighterPressed(_ sender: UIButton) {
        onButton(button: versusOpponentLabel)
        offButton(button: myFighterLabel)
        offButton(button: stageLabel)
        sortByFighterLabel.setTitle("相手", for: .normal)
        tableView.reloadData()
    }
    
    @IBAction func stapePressed(_ sender: UIButton) {
        onButton(button: stageLabel)
        offButton(button: myFighterLabel)
        offButton(button: versusOpponentLabel)
        // ステージを選択時、キャラ->ステージ
        sortByFighterLabel.setTitle("ステージ", for: .normal)
        tableView.reloadData()
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
        analyzeByOpponentFighters = realm.objects(AnalyzeByOpponentFighter.self).sorted(byKeyPath: sortedBy, ascending: ascending)
        analyzeByStages = realm.objects(AnalyzeByStage.self).sorted(byKeyPath: "stageID", ascending: ascending)
        tableView.reloadData()
    }
    
    
    // Add database of analysis
    func calculateRecord() {
        
        for i in 0...S.fightersArray.count - 1 {
            
            // myFighter
            let myGame = records?.filter("myFighter == %@",S.fightersArray[i][1])
            let myWin = myGame?.filter("result = true")
            
            let newAnalyzeByFighter = AnalyzeByFighter()
            newAnalyzeByFighter.myFighter = S.fightersArray[i][1]
            newAnalyzeByFighter.fighterID = i
            if  myGame?.count == 0  {
                newAnalyzeByFighter.gameCount = 0
                newAnalyzeByFighter.winCount = 0
                newAnalyzeByFighter.winRate = 0
                newAnalyzeByFighter.loseCount = 0
                saveAnalyzeByFighter(analyzeByFighter: newAnalyzeByFighter)
            } else {
                if let game = myGame, let win = myWin {
                    newAnalyzeByFighter.gameCount = game.count
                    newAnalyzeByFighter.winCount = win.count
                    newAnalyzeByFighter.loseCount = game.count - win.count
                    newAnalyzeByFighter.winRate = Int(CGFloat(win.count) / CGFloat(game.count) * 100)
                    saveAnalyzeByFighter(analyzeByFighter: newAnalyzeByFighter)
                }
            }
            
            // oponentFighter
            let opponentGame = records?.filter("opponentFighter == %@", S.fightersArray[i][1])
            let opponentWin = opponentGame?.filter("result = true")
            
            let newAnalyzeByOpponentFighter = AnalyzeByOpponentFighter()
            newAnalyzeByOpponentFighter.opponentFighter = S.fightersArray[i][1]
            newAnalyzeByOpponentFighter.fighterID = i

            if opponentGame?.count == 0 {
                newAnalyzeByOpponentFighter.gameCount = 0
                newAnalyzeByOpponentFighter.winCount = 0
                newAnalyzeByOpponentFighter.loseCount = 0
                newAnalyzeByOpponentFighter.winRate = 0
                saveAnalyzeByOpponentFighter(analyzeByOpponentFighter: newAnalyzeByOpponentFighter)
            } else {
                if let game = opponentGame, let win = opponentWin {
                    newAnalyzeByOpponentFighter.gameCount = game.count
                    newAnalyzeByOpponentFighter.winCount = win.count
                    newAnalyzeByOpponentFighter.loseCount = game.count - win.count
                    newAnalyzeByOpponentFighter.winRate = Int(CGFloat(win.count) / CGFloat(game.count) * 100)
                    saveAnalyzeByOpponentFighter(analyzeByOpponentFighter: newAnalyzeByOpponentFighter)
                }
            }
            
        }
        
        // stage
        for i in 0...S.stageArray.count - 1 {
            let stageGame = records?.filter("stage == %@", S.stageArray[i])
            let stageWin = stageGame?.filter("result = true")
            
            let newAnalyzeByStage = AnalyzeByStage()
            newAnalyzeByStage.stage = S.stageArray[i]
            newAnalyzeByStage.stageID = i
            if stageGame?.count == 0 {
                newAnalyzeByStage.gameCount = 0
                newAnalyzeByStage.winCount = 0
                newAnalyzeByStage.loseCount = 0
                newAnalyzeByStage.winRate = 0
                saveAnalyzeByStage(analyzeByStage: newAnalyzeByStage)
            } else {
                if let game = stageGame, let win = stageWin {
                    newAnalyzeByStage.gameCount = game.count
                    newAnalyzeByStage.winCount = win.count
                    newAnalyzeByStage.loseCount = game.count - win.count
                    newAnalyzeByStage.winRate = Int(CGFloat(win.count) / CGFloat(game.count) * 100)
                    saveAnalyzeByStage(analyzeByStage: newAnalyzeByStage)
                }
            }

        }

    }
    
    
    // MARK: - Save
    func saveAnalyzeByFighter(analyzeByFighter: AnalyzeByFighter) {
        do {
            try realm.write {
                realm.add(analyzeByFighter, update: .modified)
            }
        } catch {
            print("Error saving calculating records \(error)")
        }
    }
    
    func saveAnalyzeByOpponentFighter(analyzeByOpponentFighter: AnalyzeByOpponentFighter) {
        do {
            try realm.write {
                realm.add(analyzeByOpponentFighter, update: .modified)
            }
        } catch {
            print("Error saving calculating records \(error)")
        }
    }
    
    func saveAnalyzeByStage(analyzeByStage: AnalyzeByStage) {
        do {
            try realm.write {
                realm.add(analyzeByStage, update: .modified)
            }
        } catch {
            print("Error saving calculating records \(error)")
        }
    }
    
}



extension AnalyzeViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myFighterLabel.isSelected == true || versusOpponentLabel.isSelected {
            return S.fightersArray.count
        } else {
            return S.stageArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnalyzeTableViewCell
        cell.winRateLabel.adjustsFontSizeToFitWidth = true
        
        
        if myFighterLabel.isSelected == true {
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
        } else if versusOpponentLabel.isSelected == true {
            if let analyzeByOpponentFighters = analyzeByOpponentFighters?[indexPath.row] {
                
                guard analyzeByOpponentFighters.gameCount != 0 else {
                    cell.fighterLabel.image = UIImage(named: analyzeByOpponentFighters.opponentFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
                    cell.gameCountLabel.text = "-"
                    cell.winCountLabel.text = "-"
                    cell.loseCountLabel.text = "-"
                    cell.winRateLabel.text = "-"
                    return cell
                }

                cell.fighterLabel.image = UIImage(named: analyzeByOpponentFighters.opponentFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
                cell.gameCountLabel.text = "\(String(analyzeByOpponentFighters.gameCount))"
                cell.winCountLabel.text = "\(String(analyzeByOpponentFighters.winCount))"
                cell.loseCountLabel.text = "\(String(analyzeByOpponentFighters.loseCount))"
                cell.winRateLabel.text = "\(String(analyzeByOpponentFighters.winRate))%"
            }
        } else {
            if let analyzeByStages = analyzeByStages?[indexPath.row] {
                guard analyzeByStages.gameCount != 0 else {
                    cell.fighterLabel.image = UIImage(named: analyzeByStages.stage)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
                    cell.gameCountLabel.text = "-"
                    cell.winCountLabel.text = "-"
                    cell.loseCountLabel.text = "-"
                    cell.winRateLabel.text = "-"
                    return cell
                }
                
                cell.fighterLabel.image = UIImage(named: analyzeByStages.stage)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
                cell.gameCountLabel.text = "\(String(analyzeByStages.gameCount))"
                cell.winCountLabel.text = "\(String(analyzeByStages.winCount))"
                cell.loseCountLabel.text = "\(String(analyzeByStages.loseCount))"
                cell.winRateLabel.text = "\(String(analyzeByStages.winRate))%"
            }
        }

        
        return cell
    }
    
    // MARK: - Tableview Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
