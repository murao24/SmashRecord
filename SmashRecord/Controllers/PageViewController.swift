//
//  PageViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var pageViewControllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.delegate = self

        let myPageView  = storyboard!.instantiateViewController(identifier: "MyViewController") as! AnalyzeMyFighterViewController
        let opponentPageView = storyboard!.instantiateViewController(identifier: "OpponentViewController") as! AnalyzeOpponentViewController
        let stagePageView = storyboard!.instantiateViewController(identifier: "StagetViewController") as! AnalyzeStageViewController
        pageViewControllers = [myPageView, opponentPageView, stagePageView]

        

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
    
 
    
    


}

