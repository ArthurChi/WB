//
//  UserAccount.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/18.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {
    
    var access_token: String?
    var expires_in: NSTimeInterval = 0 {
        
        didSet {
            expiresDate = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    
    var uid: String?
    var expiresDate: NSDate?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        // 由于要coding的都是简单对象，则考虑使用反射
        let accountMirror = Mirror(reflecting: self)
        
        for child in accountMirror.children {

            if let childVaild = child.label where childVaild != "expires_in" {
                
                aCoder.encodeObject((child.value as! AnyObject), forKey: childVaild)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expiresDate = aDecoder.decodeObjectForKey("expiresDate") as? NSDate
    }
}
