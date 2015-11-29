//
//  StatusViewModel.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/19.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

final class StatusViewModel: NSObject, ResponseCollectionSerializable {
    
    var statusModel: Status
    var userImgUrl: NSURL?
    var userMemberImgName: String?
    var vipIconImgName: String?
    var createTimeStr: String?
    var sourceStr: String?
    var thumbImgUrls: [NSURL]?
    var retweeterText: String? // 转发文本
    var cellReuseID = NormalCellReuseID
    
    lazy var rowHeight: CGFloat = {
        
        var cellHeight: CGFloat = 0
        
        if self.statusModel.retweeted_status == nil {
            let homeCell = NormalCell(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellReuseID)
            cellHeight = homeCell.cellHeight(self)
        } else {
            let homeCell = ReteewterCell(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellReuseID)
            cellHeight = homeCell.cellHeight(self)
        }
        
        return cellHeight
    }()
    
    init(status:Status) {
        
        statusModel = status
        
        // 设置用户头像URL
        userImgUrl = NSURL(string: (statusModel.user?.profile_image_url ?? ""))
        
        super.init()
        
        // 用户会员
        if statusModel.user?.mbrank > 0 && statusModel.user?.mbrank < 7 {
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
        
        // 图片URL集合, 重用标识符, 转发文本
        if statusModel.retweeted_status == nil {
            thumbImgUrls = statusModel.thumbnailUrls
            cellReuseID = NormalCellReuseID
        } else {
            thumbImgUrls = statusModel.retweeted_status?.thumbnailUrls
            cellReuseID = ReteewterCellReuseID
            retweeterText = "@\((statusModel.retweeted_status?.user?.screen_name)!): \((statusModel.retweeted_status?.text)!)"
        }
        
        // TODO:
        createTimeStr = "刚刚"
        
        sourceStr = "呵呵哒"
    }
    
    // MARK:- ResponseCollectionSerializable
    class func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [StatusViewModel] {
        
        var status = [StatusViewModel]()
        
        if let jsonStatus = representation["statuses"] as? [[String:AnyObject]] {
            for dict in jsonStatus {
                status.append(StatusViewModel(status: Status(dict: dict)))
            }
        } else {
            print("返回结果是\(representation)")
        }
        
        print("新增\(status.count)条信息")
        
        return status;
    }
}
