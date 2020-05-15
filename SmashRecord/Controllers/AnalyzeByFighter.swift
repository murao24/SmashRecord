//
//  Analyze.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/15.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import RealmSwift

class AnalyzeByFighter: Object {
    
    @objc dynamic var myFighter = ""
    @objc dynamic var gameCount = 0
    @objc dynamic var winCount = 0
    @objc dynamic var loseCount = 0
    @objc dynamic var winRate = 0

    override static func primaryKey() -> String? {
        return "myFighter"
    }
}
