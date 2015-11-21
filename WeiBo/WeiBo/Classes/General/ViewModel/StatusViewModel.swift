//
//  StatusViewModel.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/19.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

final class StatusViewModel: NSObject, ResponseCollectionSerializable {

    var statusModel: Status?
    var userImgUrl: NSURL?
    var createTimeStr: String?
    
    override init() {
        super.init()
    }
    
    init(status:Status) {
        statusModel = status
        
        // 设置用户头像URL
        userImgUrl = NSURL(string: (statusModel?.user?.profile_image_url ?? ""))
        // TODO:
        createTimeStr = "刚刚"
    }
    
    // MARK:- ResponseCollectionSerializable
    class func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [StatusViewModel] {
        
        var status = [StatusViewModel]()
        
        let jsonStatus = representation["statuses"] as! [[String:AnyObject]]
        
        for dict in jsonStatus {
            status.append(StatusViewModel(status: Status(dict: dict)))
        }
        
        return status;
    }
}
