//
//  FighterViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class FighterViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var notes: Results<FighterNote>?
    
    var selectedFighter: Fighter? {
        didSet {
            loadNotes()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = selectedFighter?.fighterName
        
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
        var textView = UITextField()
        
        let alert = UIAlertController(title: "メモを追加", message: "", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        
        let action = UIAlertAction(title: "add", style: .default) { (action) in
            
            if let selectedFighter = self.selectedFighter {
                do {
                    try self.realm.write {
                        let newFighterNote = FighterNote()
                        newFighterNote.createdAt = Date()
                        newFighterNote.note = textView.text!
                        newFighterNote.parentFighter = selectedFighter.fighterName
                        selectedFighter.fighterNotes.append(newFighterNote)
                    }
                } catch {
                    print("Error saving new notes \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextFIeld) in
            textView = alertTextFIeld
        }

        alert.addAction(cancel)
        alert.addAction(action)
        
        present(alert,animated: true ,completion: nil)

    }
    
    func loadNotes() {
        notes = selectedFighter?.fighterNotes.sorted(byKeyPath: "note", ascending: true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let notes = notes?[indexPath.row] {
            cell.textLabel?.text = notes.note
        } else {
            cell.textLabel?.text = "No notes added"
        }

        return cell
        
    }

}


