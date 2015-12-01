//
//  PublishViewController.swift
//  WeiBo
//
//  Created by jie Chi on 15/11/30.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

let textViewMargin = 8

class PublishViewController: UIViewController, UITextViewDelegate {

    private lazy var textView: UITextView = {
        
        let textView = UITextView()
        
        textView.font = UIFont.systemFontOfSize(18)
        textView.textColor = UIColor.darkGrayColor()
        
        // 始终允许垂直滚动
        textView.alwaysBounceVertical = true
        // 拖拽关闭键盘
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        // 设置文本视图的代理
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var toolBar: UIToolbar = {
        
        let toolBar = UIToolbar()
        
        let toobBarItmeImgs = ["compose_toolbar_picture","compose_trendbutton_background","compose_keyboardbutton_background","compose_emoticonbutton_background"]
        
        toolBar.items = [UIBarButtonItem]()
        
        for imgName in toobBarItmeImgs {
            
            toolBar.items?.append(UIBarButtonItem(image: UIImage(named: imgName), style: .Plain, target: self, action: ""))
            
            toolBar.items?.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: ""))
        }
        
        toolBar.items?.removeLast()
        
        toolBar.tintColor = UIColor.orangeColor()
        
        return toolBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Done, target: self, action: "cancel")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .Done, target: self, action: "submit")
        
        setupUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        textView.becomeFirstResponder()
        
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(textView)
        view.addSubview(toolBar)
        
        textView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view).offset(60)
            make.height.equalTo(200)
        }
        
        textView.inputView = EmotionView()
        
        toolBar.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(44)
        }
    }
    
    func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func submit() {
        
    }
    
    
    
}
