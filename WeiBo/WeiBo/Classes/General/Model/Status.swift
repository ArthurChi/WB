//
//  Status.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/19.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    /// 微博ID
    var id: NSNumber = 0
    /// 微博信息内容
    var text: String?
    /// 微博创建时间
    var created_at: String?
    /// 微博来源
    var source: String?
    /// 缩略图配图数组 key: thumbnail_pic
    lazy var thumbnailUrls = [NSURL]()
    /// 用户模型
    var user: User?
    /// 转发微博
    var retweeted_status: Status?
    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if key == "user" {
            if let dict = value as? [String:AnyObject] {
                
                user = User(dict: dict)
            }
            return
            
        } else if key == "pic_urls" {
            
            if let picUrlsVaild = value as? [[String:AnyObject]] where picUrlsVaild.count > 0 {
                
                for dict in picUrlsVaild {
                    
                    thumbnailUrls.append(NSURL(string: (dict["thumbnail_pic"] as! String))!)
                }
                
            }
            return
            
        } else if key == "retweeted_status" {
        
            if let retweeted_statusVaild = value as? [String:AnyObject] {
                
                retweeted_status = Status(dict: retweeted_statusVaild)
            }
            
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    override var description: String {
        
        let children = Mirror(reflecting: self).children
        var properties: [String] = []
        
        for child in children {
            
            properties.append(child.label!)
        }
        
        return dictionaryWithValuesForKeys(properties).description
    }
}
