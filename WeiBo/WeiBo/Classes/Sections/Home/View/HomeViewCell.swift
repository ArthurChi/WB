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
            
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        
    }

}
