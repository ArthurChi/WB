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
        addChildViewController("首页", imageName: "tabbar_home", controller: HomeViewController())
        // Messsage
        addChildViewController("消息", imageName: "tabbar_message_center", controller: MessageViewController())
        // Discover
        addChildViewController("发现", imageName: "tabbar_discover", controller: DiscoverViewController())
        // Profile
        addChildViewController("我", imageName: "tabbar_profile", controller: ProfileViewController())
    }
    
    private func addChildViewController(title: String, imageName: String, controller: VistorViewController) {
        
        let vc = controller
        
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
    }
    
}
