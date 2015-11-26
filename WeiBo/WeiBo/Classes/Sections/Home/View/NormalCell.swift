//
//  NormalCell.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/26.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class NormalCell: HomeViewCell {

    override func setupUI() {
        super.setupUI()
        
        pictureShowView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(StatusCellMargin)
            make.top.equalTo(contentLabel.snp_bottom)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
    }
}
