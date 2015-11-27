//
//  HomeCellTopView.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/19.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

private let userImgMargin: CGFloat = 12
private let userImgWidth: CGFloat = 35

class HomeCellTopView: UIView {

    // 头像
    private lazy var userImgView = UIImageView()
    // 姓名
    private lazy var userNameLabel = UILabel(title: "")
    // 会员图标
    private lazy var memberIconView = UIImageView()
    // 认证图标
    private lazy var vipIconView = UIImageView()
    // 时间标签
    private lazy var timeLabel = UILabel(title: "", fontSize: 11, color: UIColor.darkGrayColor(), screenInset: 0)
    // 来源标签
    private lazy var sourceLabel = UILabel(title: "", fontSize: 11, color: UIColor.darkGrayColor(), screenInset: 0)
    
    var viewModel: StatusViewModel? {
        
        didSet {
            userImgView.sd_setImageWithURL(viewModel?.userImgUrl, placeholderImage: UIImage(named: "avatar_default_big"))
            // 用户名
            userNameLabel.text = viewModel?.statusModel?.user?.screen_name
            
            // 会员
            if let userMemberVaild = viewModel?.userMemberImgName {
                memberIconView.image = UIImage(named: userMemberVaild)
            }
            
            // 大V标志
            if let viewIconVaild = viewModel?.vipIconImgName {
                vipIconView.image = UIImage(named: viewIconVaild)
            }
            
            // 时间
            timeLabel.text = viewModel?.createTimeStr
            
            // 来源
            sourceLabel.text = viewModel?.sourceStr
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        
        addSubview(userImgView)
        addSubview(userNameLabel)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        userImgView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(userImgMargin)
            make.top.equalTo(self).offset(userImgMargin)
            make.width.height.equalTo(StatusCellIconWidth)
        }
        
        userNameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(userImgView.snp_right).offset(userImgMargin)
            make.top.equalTo(userImgView)
        }
        
        memberIconView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(userNameLabel.snp_right).offset(userImgMargin)
            make.top.equalTo(userNameLabel)
        }
        
        vipIconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(userImgView.snp_right)
            make.centerY.equalTo(userImgView.snp_bottom)
        }
        
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(userImgView.snp_right).offset(userImgMargin)
            make.bottom.equalTo(userImgView.snp_bottom)
        }
        
        sourceLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(timeLabel.snp_right).offset(userImgMargin)
            make.bottom.equalTo(timeLabel.snp_bottom)
        }
    }
}
