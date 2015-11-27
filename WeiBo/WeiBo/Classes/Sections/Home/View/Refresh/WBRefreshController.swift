//
//  WBRefreshController.swift
//  WeiBo
//
//  Created by jie Chi on 15/11/27.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

private let WBRefreshControlOffset: CGFloat = -60

class WBRefreshController: UIRefreshControl {

    private lazy var refreshView = WBRefreshView.refreshView()
    
    override init() {
        super.init()
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    func setupUI() {
        
        self.tintColor = UIColor.clearColor()
        
        addSubview(refreshView)
        
        print(refreshView.bounds.size.width)
        
        refreshView.snp_makeConstraints { (make) -> Void in
            
            make.center.equalTo(self)
        }
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.addObserver(self, forKeyPath: "frame", options: [], context: nil)
        }
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
        
        refreshView.startAnimation()
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        
        refreshView.stopAnimation()
    }
    
    // MARK: - KVO
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if frame.origin.y > 0 {
            return
        }
        
        if refreshing {
            return
        }
        
        if frame.origin.y < WBRefreshControlOffset && !refreshView.rotateFlag {
            refreshView.rotateFlag = true
        } else if frame.origin.y >= WBRefreshControlOffset && refreshView.rotateFlag {
            refreshView.rotateFlag = false
        }
    }
}
