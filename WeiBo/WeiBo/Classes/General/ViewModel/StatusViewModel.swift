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
    var userMemberImgName: String?
    var vipIconImgName: String?
    var createTimeStr: String?
    var sourceStr: String?
    
    override init() {
        super.init()
    }
    
    init(status:Status) {
        super.init()
        
        statusModel = status
        
        // 设置用户头像URL
        userImgUrl = NSURL(string: (statusModel?.user?.profile_image_url ?? ""))
        
        // 用户会员
        if statusModel?.user?.mbrank > 0 && statusModel?.user?.mbrank < 7 {
            userMemberImgName = "common_icon_membership_level\(status.user!.mbrank)"
        } else {
            userMemberImgName = "common_icon_membership_expired"
        }
        
        // 大V图片名称
        switch(status.user?.verified_type ?? -1) {
        case 0: vipIconImgName = "avatar_vip"
        case 2, 3, 5: vipIconImgName = "avatar_enterprise_vip"
        case 220: vipIconImgName = "avatar_grassroot"
        default: vipIconImgName = nil
        }
        
        // TODO:
        createTimeStr = "刚刚"
        
        sourceStr = "呵呵哒"
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
