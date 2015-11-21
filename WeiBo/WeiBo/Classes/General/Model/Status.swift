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
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博创建时间
    var created_at: String?
    /// 微博来源
    var source: String?
    /// 缩略图配图数组 key: thumbnail_pic
    var pic_urls: [[String: String]]?
    /// 用户模型
    var user: User?
    
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
                return
            }
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