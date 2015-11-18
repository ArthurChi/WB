//
//  UILabel+Extention.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/18.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(title: String, fontSize: CGFloat) {
        self.init()
        
        self.text = title
        self.font = UIFont.systemFontOfSize(fontSize)
        
        self.sizeToFit()
    }
}