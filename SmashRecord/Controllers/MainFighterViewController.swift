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
    
    private var filteredRecord: Results<Record>?
    
    @IBOutlet weak var fighterButton: UIButton!
    
    @IBOutlet weak var gameCountLabel: UILabel!
    @IBOutlet weak var winCountLabel: UILabel!
    @IBOutlet weak var loseCountLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let mySections = ["対戦相手", "ステージ"]
    let numberOfSections = [S.fightersArray.count, S.stageArray.count]
    
    var matrix:[[String]] = [["hoge","fuga"] ,["ohayo","hello"]]
    
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
            fighterButton.setImage(UIImage(), for: .normal)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fighterButton.layer.masksToBounds = true
        fighterButton.layer.borderWidth = 4
        fighterButton.layer.borderColor = UIColor.orange.cgColor
        fighterButton.layer.cornerRadius = (fighterButton.frame.size.width) / 2
        fighterButton.imageEdgeInsets = UIEdgeInsets(top: -10, left: -100, bottom: -10, right: -30)
    }
    
    
    @IBAction func mainFighterPressed(_ sender: Any) {
        let fighterImageVC = storyboard?.instantiateViewController(identifier: "FIghterImageViewController") as! FighterImageViewController
        fighterImageVC.switchSettingFighterImage = "mainFighter"
        self.present(fighterImageVC, animated: true, completion: nil)
    }
    
    // For total record of main fighter
    func loadTotalRecord(mainFighter: String) {
        calculateRecord()
        analyzeByFighters = realm.objects(AnalyzeByFighter.self)
        analyzeByFighters = analyzeByFighters?.filter("myFighter == %@", mainFighter)
        if let analyzeByFighters = analyzeByFighters {
            if analyzeByFighters[0].gameCount != 0 {
                gameCountLabel.text = "\(analyzeByFighters[0].gameCount)"
                winCountLabel.text = "\(analyzeByFighters[0].winCount)"
                loseCountLabel.text = "\(analyzeByFighters[0].loseCount)"
                winRateLabel.text = "\(analyzeByFighters[0].winRate)%"
            } else {
                gameCountLabel.text = "-"
                winCountLabel.text = "-"
                loseCountLabel.text = "-"
                winRateLabel.text = "-"
            }
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
        return numberOfSections[section]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnalyzeTableViewCell

        
        if indexPath.section == 0 {
            
            cell.fighterLabel.image = UIImage(named: S.fightersArray[indexPath.row][1])?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0))
            
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
        } else {
            
            cell.fighterLabel.image = UIImage(named: S.stageArray[indexPath.row])
            
            if let mainFighter = mainFighter {
                if mainFighter.count != 0 {
                    let gameCount = s[indexPath.row + 1][2] as! Int
                    let winCount = s[indexPath.row + 1][3] as! Int
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
                    
                } else {
                    cell.gameCountLabel.text = "-"
                    cell.winCountLabel.text = "-"
                    cell.loseCountLabel.text = "-"
                    cell.winRateLabel.text = "-"
                }
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
