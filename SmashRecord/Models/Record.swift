//
//  Record.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import RealmSwift

class Record: Object {
    
    dynamic var result: Bool?
    @objc dynamic var myFighter: String = ""
    @objc dynamic var opponentFighter: String = ""
    @objc dynamic var stage: String = ""

}
