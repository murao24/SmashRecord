//
//  TopViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class TopViewController: AnalyzeViewController {
    
    var pageViewController: UIPageViewController?
    var viewControllers: [UIViewController] = []

    @IBOutlet var changeRecord: [UIButton]!
    @IBOutlet var sortBy: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        onButton(button: changeRecord[0])
        onButton(button: sortBy[0])
        
        pageViewController = children.first as? UIPageViewController
        
        let ownVc = storyboard?.instantiateViewController(identifier: "MyViewController") as! AnalyzeMyFighterViewController
        let opponentVc = storyboard?.instantiateViewController(identifier: "OpponentViewController") as! AnalyzeOpponentViewController
        let stageVc = storyboard?.instantiateViewController(identifier: "StagetViewController") as! AnalyzeStageViewController
        viewControllers = [ownVc, opponentVc, stageVc]
    }
    
    func switchVC(vc: UIViewController) {
        if let pageViewController = pageViewController {
            pageViewController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func switchTopButton() {
        onButton(button: changeRecord[0])
        offButton(button: changeRecord[1])
        offButton(button: changeRecord[2])
    }

    
    @IBAction func ownButtonPressed(_ sender: UIButton) {
        ownButtonPressed(changeRecord: changeRecord, sortBy: sortBy)
        switchVC(vc: viewControllers[0])
    }
    
    @IBAction func opponentButtonPressed(_ sender: UIButton) {
        opponentButtonPressed(changeRecord: changeRecord, sortBy: sortBy)
        switchVC(vc: viewControllers[1])
    }
    @IBAction func stageButtonPressed(_ sender: Any) {
        stageButtonPressed(changeRecord: changeRecord, sortBy: sortBy)
        switchVC(vc: viewControllers[2])
    }
    
    @IBAction func sortByButtonPressed(_ sender: UIButton) {
        switchSelectedSortButton(sender: sender, sortBy: sortBy)
    }
    
}
