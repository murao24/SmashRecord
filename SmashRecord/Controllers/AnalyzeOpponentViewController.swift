//
//  OpponentViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class AnalyzeOpponentViewController: AnalyzeViewController {
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        
        onButton(button: sortByFighterLabel) 
        loadRecord(sortedBy: "fighterID", ascending: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        onButton(button: versusOpponentLabel)
        offButton(button: myFighterLabel)
        offButton(button: stageLabel)
        tableView.reloadData()
    }
    
}

extension AnalyzeOpponentViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return S.fightersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnalyzeTableViewCell
        cell.winRateLabel.adjustsFontSizeToFitWidth = true
        
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
