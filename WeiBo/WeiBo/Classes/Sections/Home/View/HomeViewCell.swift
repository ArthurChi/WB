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
            
            contentLabel.text = statusViewModel!.statusModel?.text
        }
    }
    
    private lazy var topView: HomeCellTopView = HomeCellTopView()
    
    private lazy var contentLabel: UILabel = UILabel(title: "微博正文",
        fontSize: 15,
        color: UIColor.darkGrayColor(),
        screenInset: StatusCellMargin)
    
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
        contentView.addSubview(bottomView)
        
        topView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(StatusCellIconWidth + 2 * StatusCellMargin)
        }
        
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topView.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp_left).offset(StatusCellMargin)
            
        }
        
        bottomView.backgroundColor = UIColor.greenColor()
        bottomView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.height.equalTo(44)
            make.bottom.equalTo(contentView).offset(-StatusCellMargin)
        }
    }

}
