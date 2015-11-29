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
    
    private lazy var netWorkManager = NetworkTool()
    
    private var dataSource = [StatusViewModel]()
    
    private lazy var pullupView: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        indicator.color = UIColor.lightGrayColor()
        
        return indicator
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserAccountViewModel.shareUserAccountViewModel.loginFlag {
            
            vistorView?.setInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        netWorkManager.delegate = self
        
        setupTableView()
        
        loadData()
    }
    
    func setupTableView() {
        
        tableView.separatorStyle = .None
        tableView.estimatedRowHeight = 200
        
        tableView.registerClass(NormalCell.self, forCellReuseIdentifier: NormalCellReuseID)
        tableView.registerClass(ReteewterCell.self, forCellReuseIdentifier: ReteewterCellReuseID)
        
        refreshControl = WBRefreshController()
        refreshControl!.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.tableFooterView = pullupView
    }
    
    // MARK: - tableviewDeleget and datasource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let statusViewModel = dataSource[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(statusViewModel.cellReuseID, forIndexPath: indexPath) as! HomeViewCell
        
        cell.statusViewModel = statusViewModel
        
        if indexPath.row == dataSource.count - 1 && !pullupView.isAnimating() {
            
            pullupView.startAnimating()
            
            loadData()
        }
        
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
        
        if pullupView.isAnimating() {
            var resp = response as! [StatusViewModel]
            resp.removeFirst()
            dataSource += resp
        } else {
            dataSource = response as! [StatusViewModel] + dataSource
        }
        
        refreshControl?.endRefreshing()
        pullupView.stopAnimating()
        
        tableView.reloadData()
        
        print(dataSource.count)
    }
    
    func networkToolFailueResponse(error: NSError, request: NSURLRequest) {
        
        refreshControl?.endRefreshing()
    }
}

// MARK: - Network
extension HomeViewController {
    
    func loadData() {
        
        refreshControl?.beginRefreshing()
        
        var parameters = [String:String]()
        
        if pullupView.isAnimating() {
            parameters["max_id"] = "\(dataSource.last!.statusModel!.id)"
        } else {
            if dataSource.count != 0 {
                print("id is \(dataSource.first!.statusModel!.id)")
                parameters["since_id"] = "\(dataSource.first!.statusModel!.id)"
            } else {
                parameters["since_id"] = "0"
            }
        }
        
        netWorkManager.GETCollection("https://api.weibo.com/2/statuses/home_timeline.json", parameter: parameters, itemType: StatusViewModel())
    }
}


