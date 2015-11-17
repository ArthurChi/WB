//
//  MainViewController.swift
//  WeiBo
//
//  Created by cjfire on 15/11/16.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置控制器
        setupViewControllers()
    }
    
    
    private func setupViewControllers() {
        
        // Home
        addChildViewController("首页", imageName: "tabbar_home", stroyboardName: "Home")
        // Messsage
        addChildViewController("消息", imageName: "tabbar_message_center", stroyboardName: "Message")
        // Discover
        addChildViewController("发现", imageName: "tabbar_discover", stroyboardName: "Discover")
        // Profile
        addChildViewController("我", imageName: "tabbar_profile", stroyboardName: "Profile")
    }
    
    private func addChildViewController(title: String, imageName: String, stroyboardName: String) {
        
        let sb = UIStoryboard(name: stroyboardName, bundle: nil)
        
        let vc = sb.instantiateInitialViewController()!
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
    }
    
}
