//
//  EmotionItem.swift
//  WeiBo
//
//  Created by jie Chi on 15/11/30.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class EmotionItem: NSObject {
    
    var chs: String?
    var png:String?
    var code:String?
    
    var isRemove = false
    var isEmpty = false
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    init(isRemove:Bool) {
        self.isRemove = true
        
        super.init()
    }
    
    init(isEmpty:Bool) {
        self.isEmpty = true
        
        super.init()
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
