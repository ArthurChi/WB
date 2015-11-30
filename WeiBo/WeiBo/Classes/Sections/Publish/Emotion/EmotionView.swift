//
//  EmotionView.swift
//  WeiBo
//
//  Created by jie Chi on 15/11/30.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

private let emtionViewReuseId = "emtionViewReuseId"

class EmotionView: UIView, UICollectionViewDataSource {

    private lazy var emotionManager = EmotionManager.shareEmotionManager
    
    // 选项栏
    private lazy var sectionBar: UIToolbar = {
        
        let sectionBar = UIToolbar()
        
        sectionBar.backgroundColor = UIColor.grayColor()
        
        sectionBar.items = [UIBarButtonItem]()
        
        var index = 1000
        
        for emotionPackage in self.emotionManager.emotionPackages {
            
            sectionBar.items?.append(UIBarButtonItem(title: emotionPackage.group_name_cn, style: .Plain, target: self, action: "sectionBarItemDidClicked:"))
            sectionBar.items?.last?.tag = index++
            
            sectionBar.items?.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: "", action: ""))
        }
        
        sectionBar.items?.removeLast()
        
        return sectionBar
    }()
    
    // 表情栏
    private lazy var emtionView: UICollectionView = {
        
        let col = 7
        let row = 3
        
        let w: CGFloat = self.bounds.size.width / CGFloat(col)
        let margin: CGFloat =  (self.bounds.height - CGFloat(row+1) * w) * 0.5
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSizeMake(w,w)
        layout.scrollDirection = .Horizontal
        layout.sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
        
        let emtionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        emtionView.backgroundColor = UIColor.lightGrayColor()
        emtionView.pagingEnabled = true
        emtionView.bounces = false
        
        emtionView.registerClass(EmotionViewCell.self, forCellWithReuseIdentifier: emtionViewReuseId)
        emtionView.dataSource = self
        
        return emtionView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        
        var rect = UIScreen.mainScreen().bounds
        rect.size.height = 113 * UIScreen.mainScreen().scale
        
        super.init(frame: rect)
        
        addSubview(sectionBar)
        addSubview(emtionView)
        
        sectionBar.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(22*UIScreen.mainScreen().scale)
        }
        
        emtionView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(sectionBar.snp_top)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Event Response
    func sectionBarItemDidClicked(item: UIBarButtonItem) {
        
        switch item.tag {
        case 1000:
            print("最近")
        case 1001:
            print("默认")
        case 1002:
            print("浪小花")
        case 1003:
            print("emoji")
        default:
            print("错误")
        }
    }
    
    // MARK: - collectionView datasource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return emotionManager.emotionPackages.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21 * 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(emtionViewReuseId, forIndexPath: indexPath)
        
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = UIColor.greenColor()
        } else {
            cell.backgroundColor = UIColor.redColor()
        }
        
        return cell
    }
}

class EmotionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
