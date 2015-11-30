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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 发布按钮
        let publishBtn = UIButton()
        publishBtn.setBackgroundImage(UIImage(imageLiteral: "tabbar_compose_button"), forState: .Normal)
        publishBtn.setBackgroundImage(UIImage(imageLiteral: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        publishBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        publishBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        
        publishBtn.addTarget(self, action: "publishBtnDidClick", forControlEvents: .TouchUpInside)
        publishBtn.backgroundColor = UIColor.orangeColor()
        tabBar.addSubview(publishBtn)
        tabBar.bringSubviewToFront(publishBtn)
        
        publishBtn.sizeToFit()
        publishBtn.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(tabBar)
        }
    }
    
    private func setupViewControllers() {
        
        // Home
        addChildViewController("首页", imageName: "tabbar_home", controller: HomeViewController())
        // Messsage
        addChildViewController("消息", imageName: "tabbar_message_center", controller: MessageViewController())
        // a empty viewController
        addChildViewController("", imageName: "", controller: UIViewController())
        // Discover
        addChildViewController("发现", imageName: "tabbar_discover", controller: DiscoverViewController())
        // Profile
        addChildViewController("我", imageName: "tabbar_profile", controller: ProfileViewController())
    }
    
    private func addChildViewController(title: String, imageName: String, controller: UIViewController) {
        
            let nav = UINavigationController(rootViewController: controller)
            addChildViewController(nav)
            
            controller.title = title
            controller.tabBarItem.image = UIImage(named: imageName)
    }
    
    @objc private func publishBtnDidClick() {
        
        let publishViewController = UINavigationController(rootViewController: PublishViewController())
        
       presentViewController(publishViewController, animated: true, completion: nil)
    }
}
