//
//  Fighter.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import RealmSwift

class Fighter: Object {
    
    @objc dynamic var fighterName: String = ""
    @objc dynamic var fighterID = UUID().uuidString
    let FighterNotes = List<FighterNote>()

    override static func primaryKey() -> String? {
      return "fighterID"
    }
    
}
