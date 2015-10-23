//
//  TabBarController.swift
//  DWM
//
//  Created by 高永效 on 15/9/20.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = UIColor(red: 150.0 / 255.0, green: 118.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
