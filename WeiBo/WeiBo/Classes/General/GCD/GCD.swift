//
//  GCD.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/18.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import Foundation

// MARK: - 全局函数，可以直接使用
/// 延迟在主线程执行函数
///
/// - parameter delta:    延迟时间
/// - parameter callFunc: 要执行的闭包
func delay(delta: Double, callFunc: ()->()) {
    
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, Int64(delta * Double(NSEC_PER_SEC))),
        dispatch_get_main_queue()) {
            
            callFunc()
    }
}