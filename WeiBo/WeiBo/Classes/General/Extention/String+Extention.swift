//
//  String+Extention.swift
//  WeiBo
//
//  Created by jie Chi on 15/11/30.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import Foundation

extension String {
    
    var emoji: String {
        
        let scanner = NSScanner(string: (self))
        
        var value: UInt32 = 0
        scanner.scanHexInt(&value)
        
        let chr = Character(UnicodeScalar(value))
        
        return "\(chr)"
    }
}