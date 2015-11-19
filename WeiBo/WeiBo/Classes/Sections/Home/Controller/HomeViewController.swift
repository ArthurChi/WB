//
//  HomeViewController.swift
//  WeiBo
//
//  Created by cjfire on 15/11/16.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

private let HomeViewControllerCellId = "HomeViewControllerCellId"

class HomeViewController: VistorViewController, NetworkDelegate {

    private var dataSource = [StatusViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !UserAccountViewModel.shareUserAccountViewModel.loginFlag {
            
            vistorView?.setInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // prepare
        NetworkTool.sharedTools.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(HomeViewCell.self, forCellReuseIdentifier: HomeViewControllerCellId)
        
        loadData()
    }
    
    // MARK: - tableviewDeleget and datasource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeViewControllerCellId, forIndexPath: indexPath) as! HomeViewCell
        
        cell.statusViewModel = dataSource[indexPath.row]
        
        return cell
    }
    
    
    // MARK: - NetworkDelegate
    func networkToolSuccessResponse<T>(response: T, request: NSURLRequest) {
        
        self.dataSource = response as! [StatusViewModel]
        
        tableView.reloadData()
    }
    
    func networkToolFailueResponse(error: NSError, request: NSURLRequest) {
        
    }
}

// MARK: - Network
extension HomeViewController {
    
    func loadData() {
        
        NetworkTool.GETCollection("https://api.weibo.com/2/statuses/home_timeline.json", parameter: nil, itemType: StatusViewModel())
    }
}


