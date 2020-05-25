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
        
        let ownVC = storyboard?.instantiateViewController(identifier: "MyViewController") as! AnalyzeMyFighterViewController
        let opponentVC = storyboard?.instantiateViewController(identifier: "OpponentViewController") as! AnalyzeOpponentViewController
        let stageVC = storyboard?.instantiateViewController(identifier: "StagetViewController") as! AnalyzeStageViewController

        viewControllers = [ownVC, opponentVC, stageVC]
    }
    
    func switchVC(vc: UIViewController) {
        if let pageViewController = pageViewController {
            pageViewController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func switchTopButton(sender: UIButton) {
        for i in 0...changeRecord.count - 1 {
            offButton(button: changeRecord[i])
        }
        
        switch sender.tag {
        case 0:
            onButton(button: changeRecord[0])
            sortBy[0].setTitle("自分", for: .normal)
        case 1:
            onButton(button: changeRecord[1])
            sortBy[0].setTitle("相手", for: .normal)
        case 2:
            onButton(button: changeRecord[2])
            sortBy[0].setTitle("ステージ", for: .normal)
        default:
            return
        }
    }
    
    func switchSelectedSortButton(sender: UIButton) {
        for i in 0...sortBy.count - 1 {
            offButton(button: sortBy[i])
        }
        
        switch sender.tag {
        case 0:
            onButton(button: sortBy[0])
            loadRecord(sortedBy: "fighterID", ascending: true)
        case 1:
            onButton(button: sortBy[1])
            loadRecord(sortedBy: "gameCount")
        case 2:
            onButton(button: sortBy[2])
            loadRecord(sortedBy: "winCount")
        case 3:
            onButton(button: sortBy[3])
            loadRecord(sortedBy: "loseCount")
        case 4:
            onButton(button: sortBy[4])
            loadRecord(sortedBy: "winRate")
        default:
            return
        }
    }


    
    @IBAction func ownButtonPressed(_ sender: UIButton) {
        switchTopButton(sender: sender)
        switchVC(vc: viewControllers[0])
    }
    
    @IBAction func opponentButtonPressed(_ sender: UIButton) {
        switchTopButton(sender: sender)
        switchVC(vc: viewControllers[1])
    }
    @IBAction func stageButtonPressed(_ sender: UIButton) {
        switchTopButton(sender: sender)
        switchVC(vc: viewControllers[2])
    }
    
    @IBAction func sortByButtonPressed(_ sender: UIButton) {
        switchSelectedSortButton(sender: sender)
    }
    
}
