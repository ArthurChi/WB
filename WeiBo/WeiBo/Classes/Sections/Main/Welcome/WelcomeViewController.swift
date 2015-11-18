//
//  WelcomeViewController.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/18.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

let userImgViewW: CGFloat = 90

class WelcomeViewController: UIViewController {
    
    private lazy var userImgView: UIImageView = {
        
        let userImgView = UIImageView()
        userImgView.layer.masksToBounds = true
        userImgView.layer.cornerRadius = 0.5 * userImgViewW
        
        return userImgView
    }()
    private lazy var showTextLabel = UILabel(title: "欢迎回来", fontSize: 18)
    private let bgImgView = UIImageView(image: UIImage(named: "ad_background"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animationShow()
    }
    
    func setupUI() {
        
        view.addSubview(bgImgView)
        view.addSubview(userImgView)
        view.addSubview(showTextLabel)
        
        bgImgView.snp_makeConstraints { (make) -> Void in
            
            make.edges.equalTo(view.snp_edges)
        }
        
        userImgView.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(-200)
            make.width.height.equalTo(userImgViewW)
        }
        
        showTextLabel.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(userImgView)
            make.top.equalTo(userImgView.snp_bottom).offset(20)
        }
        
        userImgView.sd_setImageWithURL(UserAccountViewModel.shareUserAccountViewModel.avatarLargeUrl, placeholderImage: UIImage(named: "avatar_default_big"))
        
        showTextLabel.hidden = true
    }
    
    func animationShow() {
        
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            
            }) { (finished) -> Void in
             
                
        }
    }
    
}
