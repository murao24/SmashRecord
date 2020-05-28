//
//  MainFighter.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/28.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import RealmSwift

class MainFighter: Object {
    
    @objc dynamic var mainFighter: String = ""
    @objc dynamic var ID: Int = 0
    
    override static func primaryKey() -> String? {
        return "ID"
    }
    
}
