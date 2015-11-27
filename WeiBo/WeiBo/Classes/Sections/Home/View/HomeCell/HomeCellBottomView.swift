//
//  HomeCellBottomView.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/19.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class HomeCellBottomView: UIView {

    // 转发
    private lazy var retweetedBtn = UIButton(title: "转发", imageName:"timeline_icon_retweet")
    // 评论
    private lazy var commentBtn = UIButton(title: "评论", imageName:"timeline_icon_comment")
    // 点赞
    private lazy var likeBtn = UIButton(title: "点赞", imageName:"timeline_icon_unlike")
    
    // 分割线
    private lazy var sepView = UIView()
    // 分割线
    private lazy var sepView1 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        addSubview(retweetedBtn)
        addSubview(commentBtn)
        addSubview(likeBtn)
        addSubview(sepView)
        addSubview(sepView1)
        
        sepView.backgroundColor = UIColor.darkGrayColor()
        sepView1.backgroundColor = sepView.backgroundColor
        
        retweetedBtn.snp_makeConstraints { (make) -> Void in
            make.top.bottom.left.equalTo(self)
        }
        
        likeBtn.snp_makeConstraints { (make) -> Void in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(retweetedBtn)
        }
        
        commentBtn.snp_makeConstraints { (make) -> Void in
            make.top.bottom.width.equalTo(retweetedBtn)
            make.left.equalTo(retweetedBtn.snp_right)
            make.right.equalTo(likeBtn.snp_left)
        }
        
        let sepW = 0.5
        let sepScale = 0.4
        
        sepView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(retweetedBtn.snp_right)
            make.width.equalTo(sepW)
            make.centerY.equalTo(retweetedBtn)
            make.height.equalTo(retweetedBtn).multipliedBy(sepScale)
        }
        
        sepView1.snp_makeConstraints { (make) -> Void in
            make.width.height.centerY.equalTo(sepView)
            make.left.equalTo(commentBtn.snp_right)
        }
    }
}
