//
//  FirstViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/02.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class NoteViewController: UIViewController {
    
    let realm = try! Realm()
    
    var fighters: Results<Fighter>?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        saveFighter()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
}


extension NoteViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: - Tableview Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return S.fightersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.fighterName.text = S.fightersArray[indexPath.row][0]
        cell.fighterView.image = UIImage(named: S.fightersArray[indexPath.row][1])
        
        return cell
    }
    
    // MARK: - Tableview Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToFighter", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destinationVC = segue.destination as! FighterViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedFighter = fighters?[indexPath.row]
        }

    }
    
    
    //MARK: - Data Manipulation Methods
    
//    private func saveFighter() {
//
//        for i in 0...S.fightersArray.count - 1 {
//            let newFighter = Fighter()
//            newFighter.fighterName = S.fightersArray[i][0]
//            try! realm.write {
//                realm.add(newFighter)
//            }
//        }
//
//    }
    
    
}
