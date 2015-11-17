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
    lazy var registerBtn = UIButton(title: "注册")
    /// 登录按钮
    lazy var loginBtn = UIButton(title: "登录")
    /// 图标
    private lazy var iconImgView = UIImageView()
    /// 文字
    private lazy var textShowLabel = UILabel()
    /// 遮罩视图
    private lazy var showdom = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    /// 首页视图
    private lazy var homeIconImgView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    /// 旋转视图
    private lazy var revolveImgView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    private func setupUI() {
        
        self.backgroundColor = UIColor.whiteColor()
        
        addSubview(iconImgView)
        addSubview(textShowLabel)
        addSubview(showdom)
        addSubview(registerBtn)
        addSubview(loginBtn)
        
        addSubview(revolveImgView)
        addSubview(homeIconImgView)
        
        textShowLabel.textAlignment = .Center
        textShowLabel.font = UIFont.systemFontOfSize(14)
        
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
    }
    
    func setInfo(text: String, imageName: String?) {
        
        textShowLabel.text = text
        
        if let imageNameVaild = imageName {
            
            iconImgView.image = UIImage(named: imageNameVaild)
        }
    }
}
