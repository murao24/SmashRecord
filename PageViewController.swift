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
        return storyboard!.instantiateViewController(identifier: "FirstViewController") as! AnalyzeViewController
    }
    
    func getSecond() -> SecondViewController {
        return storyboard!.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
    }
    
    func getThird() -> ThirdViewController {
        return storyboard!.instantiateViewController(identifier: "ThirdViewController") as! ThirdViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
         
        if viewController.isKind(of: ThirdViewController.self) {
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            return getFirst()
        } else {
            return nil
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: AnalyzeViewController.self) {
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            return getThird()
        } else {
            return nil
        }
        
    }
    
 
    
    


}

