//
//  WBRefreshView.swift
//  WeiBo
//
//  Created by jie Chi on 15/11/27.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

class WBRefreshView: UIView {

    @IBOutlet weak var refreshImgView: UIImageView!
    @IBOutlet weak var loadImgView: UIImageView!
    
    @IBOutlet weak var refreshTextLabel: UILabel!

    @IBOutlet weak var freshView: UIView!
    
    var rotateFlag: Bool = false {
        didSet {
            dragAnimation()
            
            if rotateFlag {
                refreshTextLabel.text = "松开开始刷新"
            } else {
                refreshTextLabel.text = "下拉刷新"
            }
        }
    }
    
    class func refreshView() -> WBRefreshView {
        
        let nibView = UINib(nibName: "WBRefreshView", bundle: nil)
        
        let refreshView = nibView.instantiateWithOwner(nil, options: nil).last as! WBRefreshView
        
        return refreshView
    }
    
    func dragAnimation() {
        
        var rote = CGFloat(M_PI)
        rote += rotateFlag ? -0.000001 : 0.000001
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.refreshImgView.transform = CGAffineTransformRotate(self.refreshImgView.transform, rote)
        }
    }
    
    func startAnimation() {
        
        freshView.hidden = true
        
        let animaKey = "transform.rotation"
        
        if loadImgView.layer.animationForKey(animaKey) != nil {
            return
        }
        
        let animation = CABasicAnimation(keyPath: animaKey)
        animation.toValue = 2 * M_PI
        animation.repeatCount = MAXFLOAT
        animation.duration = 0.5
        animation.removedOnCompletion = false
        
        loadImgView.layer.addAnimation(animation, forKey: animaKey)
    }
    
    func stopAnimation() {
        
        freshView.hidden = false
    }
}
