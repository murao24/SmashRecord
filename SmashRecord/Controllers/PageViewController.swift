//
//  PageViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var parentVC: TopViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parentVC = self.parent as? TopViewController
    }
    
    func getFirst() -> AnalyzeMyFighterViewController {
        return storyboard!.instantiateViewController(identifier: "MyViewController") as! AnalyzeMyFighterViewController
    }
    
    func getSecond() -> AnalyzeOpponentViewController {
        return storyboard!.instantiateViewController(identifier: "OpponentViewController") as! AnalyzeOpponentViewController
    }
    
    func getThird() -> AnalyzeStageViewController {
        return storyboard!.instantiateViewController(identifier: "StagetViewController") as! AnalyzeStageViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func switchTopButton(n: Int) {
        if let parentVC = parentVC {
            for i in 0...parentVC.changeRecord.count - 1 {
                offButton(button: parentVC.changeRecord[i])
            }
            onButton(button: parentVC.changeRecord[n])
        }
    }

}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: AnalyzeStageViewController.self) {
            return getSecond()
        } else if viewController.isKind(of: AnalyzeOpponentViewController.self) {
            return getFirst()
        } else {
            return nil
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: AnalyzeMyFighterViewController.self) {
            return getSecond()
        } else if viewController.isKind(of: AnalyzeOpponentViewController.self) {
            return getThird()
        } else {
            return nil
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        guard completed, let currentVC = pageViewController.viewControllers?.first else {
            return
        }
        
        switch currentVC {
        case is AnalyzeMyFighterViewController:
            switchTopButton(n: 0)
        case is AnalyzeOpponentViewController:
            switchTopButton(n: 1)
        case is AnalyzeStageViewController:
            switchTopButton(n: 2)
        default:
            break
        }

    }

}


