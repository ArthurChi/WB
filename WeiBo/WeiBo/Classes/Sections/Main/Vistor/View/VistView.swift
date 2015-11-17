//
//  VistView.swift
//  WeiBo
//
//  Created by cjfire on 15/11/16.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit
import SnapKit

class VistView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }

    /// 注册按钮
    lazy var registerBtn = UIButton(imageName: "common_button_white_disable", title: "注册",titleColor: UIColor.orangeColor())
    /// 登录按钮
    lazy var loginBtn = UIButton(imageName: "common_button_white_disable", title: "登录", titleColor: UIColor.darkGrayColor())
    /// 图标
    private lazy var iconImgView = UIImageView()
    /// 文字
    private lazy var textShowLabel = UILabel()
    /// 遮罩视图
    private lazy var showdomView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    /// 首页视图
    private lazy var homeIconImgView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    /// 旋转视图
    private lazy var revolveImgView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    private func setupUI() {
        
//        backgroundColor = UIColor.whiteColor()
        backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
        
        addSubview(revolveImgView)
        addSubview(showdomView)
        addSubview(iconImgView)
        addSubview(textShowLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        
        addSubview(homeIconImgView)
        
        textShowLabel.textAlignment = .Center
        textShowLabel.font = UIFont.systemFontOfSize(14)
        
        iconImgView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        
        homeIconImgView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        
        revolveImgView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        
        textShowLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(revolveImgView.snp_bottom).offset(16)
            make.height.equalTo(36)
            make.width.equalTo(224)
        }
        
        let btnMargin: CGFloat = 30
        
        registerBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(textShowLabel.snp_bottom).offset(10)
            make.right.equalTo(self.snp_centerX).offset(-btnMargin)
            make.width.equalTo(100)
        }
        
        loginBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(registerBtn)
            make.left.equalTo(self.snp_centerX).offset(btnMargin)
            make.width.equalTo(registerBtn)
        }
        
        showdomView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(registerBtn.snp_bottom)
        }
    }
    
    func setInfo(imageName: String?, title: String) {
        
        textShowLabel.text = title
        textShowLabel.numberOfLines = 0
        textShowLabel.textAlignment = .Center
        
        if let imageNameVaild = imageName {
            
            iconImgView.image = UIImage(named: imageNameVaild)
            
            sendSubviewToBack(showdomView)
            
            revolveImgView.hidden = true
            homeIconImgView.hidden = true
            
        } else {
            
            startAnimation()
        }
    }
    
    private func startAnimation() {
        
        
    }
}
