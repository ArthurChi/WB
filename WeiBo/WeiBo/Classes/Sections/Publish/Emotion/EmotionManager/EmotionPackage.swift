//
//  EmotionPackage.swift
//  WeiBo
//
//  Created by jie Chi on 15/11/30.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class EmotionPackage: NSObject {

    // 物理路径
    var packagePath: String!
    // 表情包显示名字
    var group_name_cn: String!
    // 表情数组
    var emotion = [EmotionItem]()
    
    init(dict:[String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "emoticons" {
            
            for emotionDict in value as! [[String:AnyObject]] {
                
                var emotionDictTmp = emotionDict
                
                if let png = emotionDict["png"] as? String {
                    emotionDictTmp["png"] = "\(packagePath)/\(png)"
                }
                
                let emotionItem = EmotionItem(dict: emotionDictTmp)
                emotion.append(emotionItem)
            }
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}
