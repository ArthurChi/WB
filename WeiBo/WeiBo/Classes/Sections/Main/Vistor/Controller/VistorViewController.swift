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
    var loginFlag = false
    var vistorView: VistView?
    
    override func loadView() {
        
        loginFlag ? super.loadView() : setupVistView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupVistView() {
        
        vistorView = VistView()
        view = vistorView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "loginBtnDidClicked")
    }
    
    @objc private func loginBtnDidClicked() {
        
        
    }
    
    @objc private func registBtnDidClicked() {
        
        
    }
    
}
