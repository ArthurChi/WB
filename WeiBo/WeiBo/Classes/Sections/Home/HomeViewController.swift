//
//  HomeViewController.swift
//  WeiBo
//
//  Created by cjfire on 15/11/16.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class HomeViewController: VistorViewController, NetworkDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !UserAccountViewModel.shareUserAccountViewModel.loginFlag {
            
            vistorView?.setInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        NetworkTool.sharedTools.delegate = self
        
        loadData()
    }
    
    // MARK: - NetworkDelegate
    func networkToolSuccessResponse(response: AnyObject, request: NSURLRequest) {
        
        print(response)
    }
    
    func networkToolFailueResponse(error: NSError, request: NSURLRequest) {
        
    }
    
}

// MARK: - Network
extension HomeViewController {
    
    func loadData() {
        
        NetworkTool.OAuthGET("https://api.weibo.com/2/statuses/home_timeline.json", parameter: nil)
    }
}
