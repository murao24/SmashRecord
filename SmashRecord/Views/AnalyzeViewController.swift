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
        calculateRecord()
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
        analyzeByFighters = realm.objects(AnalyzeByFighter.self)
    }
    
    func calculateRecord() {
        
        for i in 0...S.fightersArray.count - 1 {
            let game = records?.filter("myFighter == %@",S.fightersArray[i][1])
            let win = game?.filter("result = true")
            
            let newAnalyzeByFighter = AnalyzeByFighter()
            newAnalyzeByFighter.myFighter = S.fightersArray[i][1]
            if  game?.count == 0  {
                newAnalyzeByFighter.gameCount = 0
                newAnalyzeByFighter.winCount = 0
                newAnalyzeByFighter.winRate = 0
                newAnalyzeByFighter.loseCount = 0
                saveAnalyzeByFighter(analyzeByFighter: newAnalyzeByFighter)
            } else {
                
                if let game = game, let win = win {
                    
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
        
        cell.fighterLabel.image = UIImage(named: S.fightersArray[indexPath.row][1])?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
        
        if let analyzeByFighters = analyzeByFighters?[indexPath.row] {
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
