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
            
            var index = 0
            for emotionDict in value as! [[String:AnyObject]] {
                
                var emotionDictTmp = emotionDict
                
                if let png = emotionDict["png"] as? String {
                    emotionDictTmp["png"] = "\(packagePath)/\(png)"
                }
                
                if index == 20 {
                    
                    let emtionRemoveItem = EmotionItem(isRemove: true)
                    emotion.append(emtionRemoveItem)
                    index = 0
                }
                index++
                
                let emotionItem = EmotionItem(dict: emotionDictTmp)
                emotion.append(emotionItem)
            }
            
            let motionCount = emotion.count % 21
            
            if motionCount != 0 {
                
                for _ in motionCount..<20 {
                    let emotionItem = EmotionItem(isEmpty: true)
                    emotion.append(emotionItem)
                }
                
                let emotionItem = EmotionItem(isRemove: true)
                emotion.append(emotionItem)
            }
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}
