//
//  UIButton+Extention.swift
//  WeiBo
//
//  Created by cjfire on 15/11/17.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(imageName: String, title: String, titleColor: UIColor) {
        self.init()
        
        setTitle(title, forState: .Normal)
        setTitleColor(titleColor, forState: .Normal)
        setBackgroundImage(UIImage(named: imageName), forState: .Normal)
        
        
        sizeToFit()
    }
}