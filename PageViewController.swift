//
//  PageViewController.swift
//  SmashRecord
//
//  Created by 村尾慶伸 on 2020/05/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }
    
    func getFirst() -> AnalyzeViewController {
        return storyboard!.instantiateViewController(identifier: "MyViewController") as! AnalyzeViewController
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

extension PageViewController: UIPageViewControllerDataSource {
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

