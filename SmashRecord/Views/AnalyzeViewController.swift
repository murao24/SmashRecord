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
    var mainFighter: Results<MainFighter>?
    var masterRecord: Results<Record>?
    var winRecord: Results<Record>?
    var byStageRecord: Results<Record>?
    var winRecordByStage: Results<Record>?
    
    var r:[[Any]] = [[]]
    var s:[[Any]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculateRecord()
    }

    
    func loadRecord(sortedBy: String, ascending: Bool = false) {
        records = realm.objects(Record.self)
        analyzeByFighters = realm.objects(AnalyzeByFighter.self).sorted(byKeyPath: sortedBy, ascending: ascending)
        analyzeByOpponentFighters = realm.objects(AnalyzeByOpponentFighter.self).sorted(byKeyPath: sortedBy, ascending: ascending)
        guard sortedBy != "fighterID" else {
            analyzeByStages = realm.objects(AnalyzeByStage.self).sorted(byKeyPath: "stageID", ascending: true)
            return
        }
        analyzeByStages = realm.objects(AnalyzeByStage.self).sorted(byKeyPath: sortedBy, ascending: ascending)
    }
    
    func firstSortButtonSelected(sortBy: [UIButton]) {
        for i in 0...sortBy.count - 1 {
            offButton(button: sortBy[i])
        }
        onButton(button: sortBy[0])
        loadRecord(sortedBy: "fighterID", ascending: true)
    }
    
    func switchSelectedSortButton(sender: UIButton, sortBy: [UIButton]) {
        for i in 0...sortBy.count - 1 {
            offButton(button: sortBy[i])
        }

        switch sender.tag {
        case 0:
            onButton(button: sortBy[0])
            loadRecord(sortedBy: "fighterID", ascending: true)
        case 1:
            onButton(button: sortBy[1])
            loadRecord(sortedBy: "gameCount")
        case 2:
            onButton(button: sortBy[2])
            loadRecord(sortedBy: "winCount")
        case 3:
            onButton(button: sortBy[3])
            loadRecord(sortedBy: "loseCount")
        case 4:
            onButton(button: sortBy[4])
            loadRecord(sortedBy: "winRate")
        default:
            return
        }
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
    
    
    // For mainFighter
    func loadMainFighter() {
        r = [[]]
        s = [[]]
        mainFighter = realm.objects(MainFighter.self)
        records = realm.objects(Record.self)

        if mainFighter?.count != 0 {
            if let mainFighter = mainFighter?[0].mainFighter {
                
                // load mainFighter
                for i in 0...S.fightersArray.count - 1 {
                    // search mainFighter
                    records = records?.filter("myFighter == %@", mainFighter)
                    // search mainFighter * opponentFighter
                    masterRecord = records?.filter("opponentFighter == %@", S.fightersArray[i][1])
                    // search win
                    winRecord = masterRecord?.filter("result == 1")
                    
                    if let masterRecord = masterRecord {
                        
                        // recordがある
                        if masterRecord.count != 0 {
                            if let winRecord = winRecord {
                                if winRecord.count != 0 {
                                    r.append([mainFighter, S.fightersArray[i][1], masterRecord.count, winRecord.count])
                                } else {
                                    r.append([mainFighter, S.fightersArray[i][1], masterRecord.count, 0])
                                }
                            }
                        // recordがない
                        } else {
                            r.append([mainFighter, S.fightersArray[i][1], 0, 0])
                        }
                    }
                }
                
                // load stage
                for i in 0...S.stageArray.count - 1 {
                    // search mainFighter
                    records = records?.filter("myFighter == %@", mainFighter)
                    // search mainFightre * stage
                    byStageRecord = records?.filter("stage == %@", S.stageArray[i])
                    // search win
                    winRecordByStage = byStageRecord?.filter("result == 1")
                    
                    if let byStageRecord = byStageRecord {
                        // recordがある
                        if byStageRecord.count != 0 {
                            if let winRecordByStage = winRecordByStage {
                                if winRecordByStage.count != 0 {
                                    s.append([mainFighter, S.stageArray[i], byStageRecord.count, winRecordByStage.count])
                                } else {
                                    s.append([mainFighter, S.stageArray[i], byStageRecord, 0])
                                }
                            }
                        } else {
                            s.append([mainFighter, S.stageArray[i], 0, 0])
                        }
                    }
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
