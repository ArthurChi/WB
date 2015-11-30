//
//  VistorViewController.swift
//  WeiBo
//
//  Created by cjfire on 15/11/16.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class VistorViewController: UITableViewController {

    // 是否登录标识
    var loginFlag = UserAccountViewModel.shareUserAccountViewModel.loginFlag
    var vistorView: VistView?
    
    override func loadView() {
        
        loginFlag ? super.loadView() : setupVistView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tableView != nil {
            tableView.scrollsToTop = false
        }
    }

    func setupVistView() {
        
        vistorView = VistView()
        view = vistorView
        
        vistorView?.registerBtn.addTarget(self, action: "registBtnDidClicked", forControlEvents: .TouchUpInside)
        
        vistorView?.loginBtn.addTarget(self, action: "loginBtnDidClicked", forControlEvents: .TouchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "registBtnDidClicked")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "loginBtnDidClicked")
    }
    
    // MARK: - Event Response
    
    @objc private func loginBtnDidClicked() {
        
        navigationController?.presentViewController(UINavigationController(rootViewController: OAuthViewController()), animated: true, completion: nil)
    }
    
    @objc private func registBtnDidClicked() {
        
        
    }
    
}
