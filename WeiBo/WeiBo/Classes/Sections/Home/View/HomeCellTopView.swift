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
    private lazy var userNameLabel = UILabel()
    // 会员图标
    private lazy var memberIconView = UIImageView()
    // 认证图标
    private lazy var vipIconView = UIImageView()
    // 时间标签
    private lazy var timeLabel = UILabel()
    // 来源标签
    private lazy var sourceLabel = UILabel()
    
    var viewModel: StatusViewModel? {
        
        didSet {
            userImgView.sd_setImageWithURL(viewModel?.userImgUrl, placeholderImage: UIImage(named: "avatar_default_big"))
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
        
        userImgView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(userImgMargin)
            make.top.equalTo(self).offset(userImgMargin)
            make.width.height.equalTo(StatusCellIconWidth)
        }
    }
}
