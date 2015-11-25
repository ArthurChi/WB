//
//  pictureShowView.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/21.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

/// 照片之间的间距
private let StatusPictureViewItemMargin: CGFloat = 8

class PictureShowView: UICollectionView {

    var pictureUrls: [NSURL]? {
        
        didSet {
            
            sizeToFit()
        }
    }
    
    init() {
        
        let layout = UICollectionViewFlowLayout()
        super.init(frame: CGRectZero, collectionViewLayout: layout)
        backgroundColor = UIColor.greenColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func sizeThatFits(size: CGSize) -> CGSize {
        return CGSizeMake(270, CGFloat((pictureUrls?.count ?? 0) * 90))
    }
}
