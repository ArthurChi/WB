//
//  HomeViewController.swift
//  WeiBo
//
//  Created by cjfire on 15/11/16.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

let NormalCellReuseID = "NormalCellReuseID"
let ReteewterCellReuseID = "ReteewterCellReuseID"

class HomeViewController: VistorViewController, NetworkDelegate {
    
    private var dataSource = [StatusViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserAccountViewModel.shareUserAccountViewModel.loginFlag {
            
            vistorView?.setInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        tableView.separatorStyle = .None
        
        // prepare
        NetworkTool.sharedTools.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(NormalCell.self, forCellReuseIdentifier: NormalCellReuseID)
        tableView.registerClass(ReteewterCell.self, forCellReuseIdentifier: ReteewterCellReuseID)
        
        loadData()
        
        tableView.estimatedRowHeight = 200
    }
    
    // MARK: - tableviewDeleget and datasource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let statusViewModel = dataSource[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(statusViewModel.cellReuseID, forIndexPath: indexPath) as! HomeViewCell
        
        cell.statusViewModel = statusViewModel
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return dataSource[indexPath.row].rowHeight;
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


