//
//  Status.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/19.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    /// ID
    var ID: Int = 0
 /// 正文
    var text: String?
 /// 创建时间
    var create_at: String?
 /// 来源
    var source: String?
    
    var user: User?
}
