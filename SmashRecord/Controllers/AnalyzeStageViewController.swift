//
//  AnalyzeStageViewController.swift
//  
//
//  Created by 村尾慶伸 on 2020/05/21.
//

import Foundation

class AnalyzeStageViewController: AnalyzeViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        onButton(button: stageLabel)
        offButton(button: myFighterLabel)
        offButton(button: versusOpponentLabel)
    }

}
