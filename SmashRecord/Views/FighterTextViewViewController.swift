//
//  FighterTextViewViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/26.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class FighterTextViewViewController: UIViewController, UITextViewDelegate {
    
    let realm = try! Realm()
    
    private var notes: Results<FighterNote>?

    @IBOutlet weak var textView: UITextView!
    
    var selectedFighter: Fighter? {
        didSet {
            loadNotes()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = selectedFighter?.fighterName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Data manipulation Methods
    
    func loadNotes() {
        notes = realm.objects(FighterNote.self).sorted(byKeyPath: "parentFighter", ascending: true)
    }
    
    
    // MARK: - textView Delegate Methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let navigationItem: UIBarButtonItem = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(self.donePressed))
        self.navigationItem.rightBarButtonItem = navigationItem
    }
    
    @objc func donePressed() {
        textView.resignFirstResponder()
        self.navigationItem.rightBarButtonItem = .none
        
        // save
        if let selectedFighter = self.selectedFighter {
            
            let newNote = FighterNote()
            newNote.createdAt = Date()
            newNote.note = self.textView.text!
            newNote.parentFighter = selectedFighter.fighterName
            save(note: newNote)
            
        }

    }

    func save(note: FighterNote) {
        do {
            try realm.write {
                realm.add(note, update: .modified)
            }
        } catch {
            print("Error saving fighterNote \(error)")
        }
    }
    

}
