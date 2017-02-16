//
//  MenuViewController.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/26.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit

class MenuViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homePageVC = UINavigationController(rootViewController: HomePageViewController(nibName: "HomePageViewController", bundle: nil))
        let graphicDataVC = UINavigationController(rootViewController: GraphicDataViewController())
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        
        homePageVC.tabBarItem.title = "HomePage"
        graphicDataVC.tabBarItem.title = "Data"
        settingVC.tabBarItem.title = "Setting"
        viewControllers = [graphicDataVC, homePageVC, settingVC]
        
        selectedViewController = homePageVC
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
