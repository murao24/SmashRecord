//
//  AnalyzeViewController2.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class AnalyzeMyFighterViewController: AnalyzeViewController{
    
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        
        onButton(button: sortBy[0])
        loadRecord(sortedBy: "fighterID", ascending: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        onButton(button: changeRecord[0])
        offButton(button: changeRecord[1])
        offButton(button: changeRecord[2])
        tableView.reloadData()
    }

}

extension AnalyzeMyFighterViewController: UITableViewDataSource, UITableViewDelegate {
    
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
