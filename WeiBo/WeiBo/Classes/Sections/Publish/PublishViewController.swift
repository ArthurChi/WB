//
//  PublishViewController.swift
//  WeiBo
//
//  Created by jie Chi on 15/11/30.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

let textViewMargin = 8

class PublishViewController: UIViewController {

    private lazy var placeholderLabel: UILabel = {
        
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = "输入一些内容..."
        placeholderLabel.font = UIFont.systemFontOfSize(16)
        placeholderLabel.textColor = UIColor.grayColor()
        
        return placeholderLabel
    }()
    
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
        
        var index = 1000
        for imgName in toobBarItmeImgs {
            
            toolBar.items?.append(UIBarButtonItem(image: UIImage(named: imgName), style: .Plain, target: self, action: "toolBarItemClick:"))
            toolBar.items?.last?.tag = index++
            
            toolBar.items?.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: ""))
        }
        
        toolBar.items?.removeLast()
        
        toolBar.tintColor = UIColor.orangeColor()
        
        return toolBar
    }()
    
    private lazy var emotionView: EmotionView = {
        
        let emotionView = EmotionView()
        
        emotionView.delegate = self
        
        return emotionView
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Done, target: self, action: "cancel")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .Done, target: self, action: "submit")
        
        navigationItem.rightBarButtonItem?.enabled = false
        
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardChange:", name: UIKeyboardWillChangeFrameNotification, object: .None)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: .None)
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(textView)
        view.addSubview(toolBar)
        textView.addSubview(placeholderLabel)
        
        toolBar.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(44)
        }
        
        textView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view)
            make.bottom.equalTo(toolBar)
        }
        
        placeholderLabel.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(8)
        }
    }
    
    // MARK: - Event response
    func keyboardChange(notification:NSNotification) {
        print(notification)
        
        let animationDuration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        let animationDurationCurve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! Int
        
        let rect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let offset = -UIScreen.mainScreen().bounds.height + rect.origin.y
        
        toolBar.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(offset)
        }
        
        UIView.animateWithDuration(animationDuration) { () -> Void in
            
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: animationDurationCurve)!)
            
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: tool bar event
    func toolBarItemClick(toolBarItem:UIBarButtonItem) {
        
        textView.resignFirstResponder()
        
        switch toolBarItem.tag {
        case 1002:
            textView.inputView = nil
            textView.becomeFirstResponder()
        case 1003:
            textView.inputView = emotionView
            textView.becomeFirstResponder()
        default:
            print(toolBarItem.tag)
        }
    }
    
    func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func submit() {
        
    }
    
    
    
}

// MARK: - UITextViewDelegate
extension PublishViewController: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        placeholderLabel.hidden = textView.hasText()
    }
}

// MARK: - EmotionViewDelegate
extension PublishViewController: EmotionViewDelegate {
    func emotionView(emotionView: EmotionView, inputEmotionItem: EmotionItem) {
        textView.inputEmotion(inputEmotionItem)
    }
}