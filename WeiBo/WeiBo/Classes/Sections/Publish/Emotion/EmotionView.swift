//
//  EmotionView.swift
//  WeiBo
//
//  Created by jie Chi on 15/11/30.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class EmotionView: UIView {

    private lazy var emotionManager = EmotionManager.shareEmotionManager
    
    // 选项栏
    private lazy var sectionBar: UIToolbar = {
        
        let sectionBar = UIToolbar()
        
        sectionBar.backgroundColor = UIColor.grayColor()
        
        sectionBar.items = [UIBarButtonItem]()
        
        var index = 1000
        
        for emotionPackage in self.emotionManager.emotionPackages {
            
            sectionBar.items?.append(UIBarButtonItem(title: emotionPackage.group_name_cn, style: .Plain, target: self, action: "sectionBarItemDidClicked:"))
            sectionBar.items?.last?.tag = index++
            
            sectionBar.items?.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: "", action: ""))
        }
        
        sectionBar.items?.removeLast()
        
        return sectionBar
    }()
    
    // 表情栏
    private lazy var emtionView: UIScrollView = {
        
        let emtionView = UIScrollView()
        emtionView.backgroundColor = UIColor.lightGrayColor()
        return emtionView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        
        var rect = UIScreen.mainScreen().bounds
        rect.size.height = 226
        
        super.init(frame: rect)
        
        addSubview(sectionBar)
        addSubview(emtionView)
        
        sectionBar.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(44)
        }
        
        emtionView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(sectionBar.snp_top)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Event Response
    func sectionBarItemDidClicked(item: UIBarButtonItem) {
        
        switch item.tag {
        case 1000:
            print("最近")
        case 1001:
            print("默认")
        case 1002:
            print("浪小花")
        case 1003:
            print("emoji")
        default:
            print("错误")
        }
    }
}
