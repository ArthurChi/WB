//
//  PictureCollectionViewCell.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/26.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class PictureCollectionViewCell: UICollectionViewCell {
    
    var imgUrl: NSURL? {
        
        didSet {
            imgView.sd_setImageWithURL(imgUrl)
        }
    }
    
    private lazy var imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        contentView.addSubview(imgView)
        // 设置填充模式
        imgView.contentMode = UIViewContentMode.ScaleAspectFill
        // 需要裁切图片
        imgView.clipsToBounds = true
        
        imgView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
    }
}
