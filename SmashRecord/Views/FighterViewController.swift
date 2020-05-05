//
//  FighterViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class FighterViewController: UITableViewController, UITextViewDelegate {
    
    let realm = try! Realm()
    
    private var notes: Results<FighterNote>?
    
    @IBOutlet weak var fighterName: UILabel!
    
    private var textField = UITextField()
    
    var selectedFighter: Fighter? {
        didSet {
            loadNotes()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = selectedFighter?.fighterName
    }
    
    
    // MARK: - Data manipulation Methods
    func loadNotes() {
        notes = selectedFighter?.fighterNotes.sorted(byKeyPath: "note", ascending: true)
        tableView.reloadData()
    }
    
    func delete(at IndexPath: IndexPath) {
        
        if let notes = self.notes?[IndexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(notes)
                }
            } catch {
                print("Error deleting notes \(error)")
            }
        }

    }

    
    // MARK: - Tableview Datasource Methods
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
    
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action =  UIContextualAction(style: .destructive, title: nil, handler: { (_, _, completionHandler ) in
            self.delete(at: indexPath)
            self.tableView.reloadData()
            completionHandler(true)
        })
        
        action.image = UIImage(named: "delete-icon")
        action.backgroundColor = .red
        let configulation = UISwipeActionsConfiguration(actions: [action])
        
        return configulation

    }
    
    // MARK: - Add data Methods
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
//        let rect = CGRect(x: 15, y: 45, width: 240, height: 120)
//        let textView = UITextView(frame: rect)
        
        let alert = UIAlertController(title: "メモを追加", message: "", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        
        let action = UIAlertAction(title: "add", style: .default) { (action) in
            
            if let selectedFighter = self.selectedFighter {
                do {
                    try self.realm.write {
                        let newFighterNote = FighterNote()
                        newFighterNote.createdAt = Date()
                        newFighterNote.note = self.textField.text!
                        newFighterNote.parentFighter = selectedFighter.fighterName
                        selectedFighter.fighterNotes.append(newFighterNote)
                    }
                } catch {
                    print("Error saving new notes \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        // textView
//        alert.view.addSubview(textView)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "add a note"
            self.textField = alertTextField
        }

        alert.addAction(cancel)
        alert.addAction(action)
        
        present(alert,animated: true ,completion: nil)

    }

}


