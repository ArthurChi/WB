//
//  NewFeatureViewController.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/18.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "NewFeatureViewControllerCell"
private let pageCount = 4

class NewFeatureViewController: UICollectionViewController {

    init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        
        super.init(collectionViewLayout: layout)
        
        self.collectionView?.pagingEnabled = true
        self.collectionView?.bounces = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pageCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewFeatureCell
    
        cell.imageIndex = indexPath.item
        
        return cell
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        
        if page == pageCount - 1 {
            let cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forItem: page, inSection: 0)) as! NewFeatureCell
            
            cell.showBtnAnimation()
        }
    }
}

private class NewFeatureCell: UICollectionViewCell {
    
    private lazy var iconImageView = UIImageView()
    private lazy var startBtn = UIButton(imageName: "new_feature_finish_button", title: "开始体验", titleColor: UIColor.whiteColor())
    
    var imageIndex: Int = 0 {
        didSet {
            iconImageView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
            
            startBtn.hidden = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(startBtn)
        
        iconImageView.frame = contentView.bounds
        startBtn.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView.snp_centerX)
            make.bottom.equalTo(contentView).multipliedBy(0.7)
        }
    }
    
    func showBtnAnimation() {
        
        startBtn.hidden = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
