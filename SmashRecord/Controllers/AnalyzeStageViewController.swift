//
//  AnalyzeStageViewController.swift
//  
//
//  Created by 村尾慶伸 on 2020/05/21.
//

import UIKit

class AnalyzeStageViewController: AnalyzeViewController {
    
    @IBOutlet var changeRecord: [UIButton]!
    @IBOutlet var sortBy: [UIButton]!
    
    
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        
        onButton(button: sortBy[0])
        loadRecord(sortedBy: "fighterID", ascending: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        onButton(button: changeRecord[2])
        offButton(button: changeRecord[0])
        offButton(button: changeRecord[1])
        sortBy[0].setTitle("ステージ", for: .normal)
    }
    
    @IBAction func ownButtonPressed(_ sender: UIButton) {
        ownButtonPressed(changeRecord: changeRecord, sortBy: sortBy)
    }
    
    
    @IBAction func opponentButtonPressed(_ sender: UIButton) {
        opponentButtonPressed(changeRecord: changeRecord, sortBy: sortBy)
    }
    
    @IBAction func stageButtonPressed(_ sender: UIButton) {
        stageButtonPressed(changeRecord: changeRecord, sortBy: sortBy)
    }
    
    @IBAction func switchSortButtonPressed(_ sender: UIButton) {
        switchSelectedSortButton(sender: sender, sortBy: sortBy)
    }
    
}

extension AnalyzeStageViewController: UITableViewDataSource
, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return S.stageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnalyzeTableViewCell
        cell.winRateLabel.adjustsFontSizeToFitWidth = true
        
        
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
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
