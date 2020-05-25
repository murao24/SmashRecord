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

    override func viewDidLoad() {
        super.viewDidLoad()

        onButton(button: changeRecord[0])

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
        case 1:
            onButton(button: changeRecord[1])
        case 2:
            onButton(button: changeRecord[2])
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

}
