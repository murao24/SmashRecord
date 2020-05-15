//
//  Analyze.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/15.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import RealmSwift

class Analyze: Object {
    
    @objc dynamic var myFighter = ""
    @objc dynamic var opponentFighter = ""
    @objc dynamic var stage = ""
    @objc dynamic var winRate: CGFloat = 0.0

}
