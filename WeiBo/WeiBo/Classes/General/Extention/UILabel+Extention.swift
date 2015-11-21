//
//  UILabel+Extention.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/18.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(title: String,
        fontSize: CGFloat = 14,
        color: UIColor = UIColor.darkGrayColor(),
        screenInset: CGFloat = 0) {
            
            self.init()
            
            text = title
            textColor = color
            font = UIFont.systemFontOfSize(fontSize)
            
            numberOfLines = 0
            
            if screenInset == 0 {
                textAlignment = .Center
            } else {
                // 设置换行宽度
                preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 2 * screenInset
                textAlignment = .Left
            }
            
            sizeToFit()
    }
}