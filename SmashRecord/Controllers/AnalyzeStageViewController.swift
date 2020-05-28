//
//  AnalyzeStageViewController.swift
//  
//
//  Created by 村尾慶伸 on 2020/05/21.
//

import UIKit

class AnalyzeStageViewController: AnalyzeViewController {
    
    @IBOutlet var sortBy: [UIButton]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        
        loadRecord(sortedBy: "fighterID", ascending: true)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        firstSortButtonSelected(sortBy: sortBy)
        sortBy[0].setTitle("ステージ", for: .normal)
        tableView.reloadData()
    }
    
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        switchSelectedSortButton(sender: sender, sortBy: sortBy)
        tableView.reloadData()
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
            
            cell.fighterLabel.image = UIImage(named: analyzeByStages.stage)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
            
            guard analyzeByStages.gameCount != 0 else {
                cell.gameCountLabel.text = "-"
                cell.winCountLabel.text = "-"
                cell.loseCountLabel.text = "-"
                cell.winRateLabel.text = "-"
                return cell
            }
            
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
