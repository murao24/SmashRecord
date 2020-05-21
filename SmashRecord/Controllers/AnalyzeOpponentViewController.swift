//
//  OpponentViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

class AnalyzeOpponentViewController: AnalyzeViewController {
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onButton(button: versusOpponentLabel)
        offButton(button: myFighterLabel)
        offButton(button: stageLabel)
    }
    
}
