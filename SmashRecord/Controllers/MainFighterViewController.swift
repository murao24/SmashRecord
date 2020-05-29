//
//  AccountViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/02.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class MainFighterViewController: AnalyzeViewController {
    
    private var mainFighter: Results<MainFighter>?
    private var filteredRecord: Results<Record>?
    
    @IBOutlet weak var fighterButton: UIButton!
    
    @IBOutlet weak var gameCountLabel: UILabel!
    @IBOutlet weak var winCountLabel: UILabel!
    @IBOutlet weak var loseCountLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let mySections = ["対戦相手", "ステージ"]
    
    var matrix:[[String]] = [["hoge","fuga"] ,["ohayo","hello"]]
    
    var r:[[Any]] = [[]]
    
    var masterRecord: Results<Record>?
    var winRecord: Results<Record>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        
        loadMainFighter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMainFighter()
        
        if mainFighter?.count == 0 {
            fighterButton.setImage(UIImage(named: "mario"), for: .normal)
            gameCountLabel.text = "-"
            winCountLabel.text = "-"
            loseCountLabel.text = "-"
            winRateLabel.text = "-"
        } else {
            if let mainFighter = mainFighter {
                fighterButton.setImage(UIImage(named: mainFighter[0].mainFighter), for: .normal)
                loadTotalRecord(mainFighter: mainFighter[0].mainFighter)
            }
        }
        
        tableView.reloadData()
    }
    
    
    @IBAction func mainFighterPressed(_ sender: Any) {
        let fighterImageVC = storyboard?.instantiateViewController(identifier: "FIghterImageViewController") as! FighterImageViewController
        fighterImageVC.switchSettingFighterImage = "mainFighter"
        self.present(fighterImageVC, animated: true, completion: nil)
    }
    
    func loadMainFighter() {
        r = [[]]
        mainFighter = realm.objects(MainFighter.self)
        records = realm.objects(Record.self)

        if mainFighter?.count != 0 {
            if let mainFighter = mainFighter?[0].mainFighter {
                
                for i in 0...S.fightersArray.count - 1 {
                    // search mainFighter
                    records = records?.filter("myFighter == %@", mainFighter)
                    // search mainFighter * opponentFighter
                    masterRecord = records?.filter("opponentFighter == %@", S.fightersArray[i][1])

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
            }
        }

    }
    
    func loadTotalRecord(mainFighter: String) {
        analyzeByFighters = realm.objects(AnalyzeByFighter.self)
        analyzeByFighters = analyzeByFighters?.filter("myFighter == %@", mainFighter)
        if let analyzeByFighters = analyzeByFighters {
            gameCountLabel.text = "\(analyzeByFighters[0].gameCount)"
            winCountLabel.text = "\(analyzeByFighters[0].winCount)"
            loseCountLabel.text = "\(analyzeByFighters[0].loseCount)"
            winRateLabel.text = "\(analyzeByFighters[0].winRate)%"
        }
    }
    
    func createMainFighter(fighterName: String) {
        let newMainFighter = MainFighter()
        newMainFighter.mainFighter = fighterName
        newMainFighter.ID = 0
        save(mainFighter: newMainFighter)
    }
    
    func save(mainFighter: MainFighter) {
        do {
            try realm.write {
                realm.add(mainFighter, update: .modified)
            }
        } catch {
            print("Error saving mainFighter \(error)")
        }
    }
    
}

extension MainFighterViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return S.fightersArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnalyzeTableViewCell
        
        cell.fighterLabel.image = UIImage(named: S.fightersArray[indexPath.row][1])
        
        if let mainFighter = mainFighter {
            
            if mainFighter.count != 0 {
                
                let gameCount = r[indexPath.row + 1][2] as! Int
                let winCount = r[indexPath.row + 1][3] as! Int
                let loseCount = gameCount - winCount
                var winRate = 0
                if gameCount != 0 {
                    winRate = Int(CGFloat(winCount) / CGFloat(gameCount) * 100)
                }
                
                if gameCount != 0 {
                    cell.gameCountLabel.text = "\(gameCount)"
                    cell.winCountLabel.text = "\(winCount)"
                    cell.loseCountLabel.text = "\(loseCount)"
                    cell.winRateLabel.text = "\(winRate)%"
                } else {
                    cell.gameCountLabel.text = "-"
                    cell.winCountLabel.text = "-"
                    cell.loseCountLabel.text = "-"
                    cell.winRateLabel.text = "-"
                }
            }
            else {
                cell.gameCountLabel.text = "-"
                cell.winCountLabel.text = "-"
                cell.loseCountLabel.text = "-"
                cell.winRateLabel.text = "-"
            }
        }
        
        
        return cell
    }

}
