//
//  UIButton+Extention.swift
//  WeiBo
//
//  Created by cjfire on 15/11/17.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String) {
        self.init()
        
        self.titleForState(.Normal)
    }
}