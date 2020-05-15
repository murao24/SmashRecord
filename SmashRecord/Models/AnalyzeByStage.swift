//
//  AnalyzeByStage.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/15.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import RealmSwift

class AnalyzeByStage: Object {
    
    @objc dynamic var stageID = 0
    @objc dynamic var stage = ""
    @objc dynamic var gameCount = 0
    @objc dynamic var winCount = 0
    @objc dynamic var loseCount = 0
    @objc dynamic var winRate = 0

    override static func primaryKey() -> String? {
        return "stage"
    }
}
