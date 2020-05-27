//
//  FighterNote.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import RealmSwift

class FighterNote: Object {
    
    @objc dynamic var parentFighter: String = ""
    @objc dynamic var note: String = ""

    override static func primaryKey() -> String? {
        return "parentFighter"
    }
    
}
