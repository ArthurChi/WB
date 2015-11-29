//
//  HomeViewCell.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/19.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

/// 微博 Cell 中控件的间距数值
let StatusCellMargin: CGFloat = 12
/// 微博头像的宽度
let StatusCellIconWidth: CGFloat = 35

class HomeViewCell: UITableViewCell {
    
    var statusViewModel: StatusViewModel? {
        
        didSet {

            topView.viewModel = statusViewModel
            
            contentLabel.text = statusViewModel!.statusModel.text
            
            pictureShowView.pictureUrls = statusViewModel?.thumbImgUrls
            
            pictureShowView.snp_updateConstraints { (make) -> Void in
                make.height.equalTo(pictureShowView.bounds.size.height)
                make.width.equalTo(pictureShowView.bounds.size.width)
            }
        }
    }
    
    // 头部容器
    private lazy var topView: HomeCellTopView = HomeCellTopView()
    
    // 内容容器
    lazy var contentLabel: UILabel = UILabel(title: "微博正文",
        fontSize: 15,
        color: UIColor.darkGrayColor(),
        screenInset: StatusCellMargin)
    
    // 图片容器
    lazy var pictureShowView = PictureShowView()
    
    // 底部容器
    private lazy var bottomView: HomeCellBottomView = HomeCellBottomView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(pictureShowView)
        contentView.addSubview(bottomView)
        
        topView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(StatusCellIconWidth + 2 * StatusCellMargin)
        }
        
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topView.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp_left).offset(StatusCellMargin)
        }
        
        bottomView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(pictureShowView.snp_bottom).offset(StatusCellMargin)
            make.left.right.equalTo(contentView)
            make.height.equalTo(44)
        }
    }
    
    func cellHeight(viewModel:StatusViewModel) -> CGFloat {
        
        self.statusViewModel = viewModel
        
        contentView.layoutIfNeeded()
        
        return CGRectGetMaxY(bottomView.frame)
    }
}
