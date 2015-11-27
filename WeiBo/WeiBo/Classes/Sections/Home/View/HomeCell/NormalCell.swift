//
//  NormalCell.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/26.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class NormalCell: HomeViewCell {

    override var statusViewModel: StatusViewModel? {
        didSet {
            
            pictureShowView.snp_updateConstraints { (make) -> Void in
                
                let count = (statusViewModel?.statusModel?.thumbnailUrls.count ?? 0)
                make.top.equalTo(contentLabel.snp_bottom).offset(count > 0 ? StatusCellMargin:0)
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        pictureShowView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(StatusCellMargin)
            make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
    }
}
