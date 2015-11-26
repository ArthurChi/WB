//
//  pictureShowView.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/21.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

/// 照片之间的间距
private let PictureCellReuseID = "PictureCellReuseID"
let StatusPictureViewItemMargin: CGFloat = 8

class PictureShowView: UICollectionView, UICollectionViewDataSource {
    
    var pictureUrls: [NSURL]? {
        
        didSet {
            
            sizeToFit()
            
            reloadData()
        }
    }
    
    init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = StatusPictureViewItemMargin
        layout.minimumLineSpacing = StatusPictureViewItemMargin
        
        super.init(frame: CGRectZero, collectionViewLayout: layout)
        
        bounces = false
        registerClass(PictureCollectionViewCell.self, forCellWithReuseIdentifier: "PictureCellReuseID")
        dataSource = self
        
        //        backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        
        
        let rowCount: CGFloat = 3
        
        let maxWidth = UIScreen.mainScreen().bounds.width - 2 * StatusCellMargin
        let itemWidth = (maxWidth - 2 * StatusPictureViewItemMargin) / rowCount
        
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        
        guard let count = pictureUrls?.count where count != 0 else {
            
            return CGSizeZero
        }
        
        switch count {
            
        case 1 :
            let size = CGSize(width: 150, height: 120)
            
            layout.itemSize = size
            
            return size
            
        case 4 :
            let w = 2 * itemWidth + StatusPictureViewItemMargin
            
            return CGSize(width: w, height: w)
        default :
            
            let row = CGFloat((count - 1) / Int(rowCount) + 1)
            let h = row * itemWidth + (row - 1) * StatusPictureViewItemMargin
            let w = rowCount * itemWidth + (rowCount - 1) * StatusPictureViewItemMargin
            
            return CGSize(width: w, height: h)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (pictureUrls?.count ?? 0)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PictureCellReuseID, forIndexPath: indexPath) as! PictureCollectionViewCell
        
        cell.imgUrl = pictureUrls![indexPath.item]
        
        return cell
    }
}
