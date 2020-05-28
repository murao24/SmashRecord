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
    
    @IBOutlet weak var fighterButton: UIButton!
    
    @IBOutlet weak var gameCountLabel: UILabel!
    @IBOutlet weak var winCountLabel: UILabel!
    @IBOutlet weak var loseCountLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let mySections = ["対戦相手", "ステージ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    @IBAction func mainFighterPressed(_ sender: Any) {
        let fighterImageVC = storyboard?.instantiateViewController(identifier: "FIghterImageViewController") as! FighterImageViewController
        fighterImageVC.switchSettingFighterImage = "mainFighter"
        self.present(fighterImageVC, animated: true, completion: nil)
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
        
        return cell
    }

}
