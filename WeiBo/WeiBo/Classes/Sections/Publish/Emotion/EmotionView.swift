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
        
        sectionBar.tintColor = UIColor.darkGrayColor()
        
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
    lazy var emtionView: UICollectionView = {
        
        let col = 7
        let row = 3
        
        let w: CGFloat = self.bounds.size.width / CGFloat(col)
        let margin: CGFloat =  (self.bounds.height - CGFloat(row + Int(UIScreen.mainScreen().scale)-1) * w) * 0.5
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSizeMake(w,w)
        layout.scrollDirection = .Horizontal
        layout.sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
        
        let emtionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        emtionView.backgroundColor = UIColor.whiteColor()
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
        
        setupUI()
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.emtionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 1), atScrollPosition: .Left, animated: true)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
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
    
    // MARK: - Event Response
    func sectionBarItemDidClicked(item: UIBarButtonItem) {
        emtionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: item.tag-1000), atScrollPosition: .Left, animated: true)
    }
    
    // MARK: - collectionView datasource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return emotionManager.emotionPackages.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotionManager.emotionPackages[section].emotion.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(emtionViewReuseId, forIndexPath: indexPath) as! EmotionViewCell
        
        let emotionItem = emotionManager.emotionPackages[indexPath.section].emotion[indexPath.item]
        cell.emotionItem = emotionItem
        
        return cell
    }
}

class EmotionViewCell: UICollectionViewCell {
    
    var emotionItem: EmotionItem! {
        didSet {
            let emotionPath = "\(NSBundle.mainBundle().bundlePath)/\(emotionItem.png ?? "")"
            emotionBtn.setImage(UIImage(contentsOfFile: emotionPath), forState: .Normal)
            
            emotionBtn.setTitle(emotionItem.code?.emoji, forState: .Normal)
            emotionBtn.titleLabel?.font = UIFont.systemFontOfSize(32)
            
            if emotionItem.isRemove {
                emotionBtn.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: .Normal)
            }
            
            if emotionItem.isEmpty {
                emotionBtn.setImage(nil, forState: .Normal)
                emotionBtn.setTitle(nil, forState: .Normal)
            }
        }
    }
    
    private lazy var emotionBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(emotionBtn)
        
        emotionBtn.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
