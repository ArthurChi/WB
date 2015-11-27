//
//  ReteewterCell.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/26.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class ReteewterCell: HomeViewCell {

    private lazy var retweetedBgView = UIView()
    
    private lazy var retweetedTextLabel = UILabel(title: "", fontSize: 14, color: UIColor.darkGrayColor(), screenInset: StatusCellMargin)
    
    override var statusViewModel: StatusViewModel? {

        didSet {
            
            retweetedTextLabel.text = statusViewModel?.retweeterText
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        contentView.insertSubview(retweetedBgView, belowSubview: pictureShowView)
        contentView.insertSubview(retweetedTextLabel, aboveSubview: retweetedBgView)
        
        retweetedBgView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        pictureShowView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(StatusCellMargin)
            make.top.equalTo(retweetedTextLabel.snp_bottom).offset(StatusCellMargin)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
        
        retweetedBgView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView).offset(StatusCellMargin)
            make.right.equalTo(contentView).offset(-StatusCellMargin)
            make.bottom.equalTo(pictureShowView)
        }
        
        retweetedTextLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(retweetedBgView).offset(StatusCellMargin)
            make.left.equalTo(retweetedBgView)
        }
    }
}
