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

    private lazy var textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Done, target: self, action: "cancel")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .Done, target: self, action: "submit")
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.whiteColor()
        
        textView.layer.borderWidth = 0.5 * UIScreen.mainScreen().scale
        textView.layer.borderColor = UIColor.grayColor().CGColor
        view.addSubview(textView)
        
        textView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view).offset(60)
            make.height.equalTo(200)
        }
        
        textView.inputView = EmotionView()
    }
    
    func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func submit() {
        
    }
    
    
    
}
