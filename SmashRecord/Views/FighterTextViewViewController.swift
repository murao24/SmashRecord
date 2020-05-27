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
    
    var selectedFighter = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = selectedFighter
        loadNotes()
        
        guard notes?.count != 0 else {
            textView.text = ""
            return
        }
        textView.text = "\(notes![0].note)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Data manipulation Methods
    
    func loadNotes() {
        notes = realm.objects(FighterNote.self).filter("parentFighter CONTAINS[cd] %@", selectedFighter)
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
        let newNote = FighterNote()
        newNote.note = self.textView.text!
        newNote.parentFighter = selectedFighter
        save(note: newNote)

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

extension FighterTextViewViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let newNote = FighterNote()
        newNote.note = self.textView.text!
        newNote.parentFighter = selectedFighter
        save(note: newNote)
    }
    
}
