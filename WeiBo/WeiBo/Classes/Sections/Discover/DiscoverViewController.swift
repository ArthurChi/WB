//
//  DiscoverViewController.swift
//  WeiBo
//
//  Created by cjfire on 15/11/16.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class DiscoverViewController: VistorViewController, NetworkDelegate {

    private lazy var networkManager = NetworkTool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vistorView?.setInfo("visitordiscover_image_message", title: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        networkManager.delegate = self
    }
    
    // MARK: - NetworkDelegate
    func networkToolSuccessResponse<T>(response: T, request: NSURLRequest) {
        
    }
    
    func networkToolFailueResponse(error: NSError, request: NSURLRequest) {
        
    }

}
