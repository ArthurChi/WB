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
    @IBOutlet weak var loadLabel: UILabel!
    
    @IBOutlet weak var refreshTextLabel: UILabel!

    @IBOutlet weak var freshView: UIView!
    
    var rotateFlag: Bool = false {
        didSet {
            startAnimation()
        }
    }
    
    class func refreshView() -> WBRefreshView {
        
        let nibView = UINib(nibName: "WBRefreshView", bundle: nil)
        
        let refreshView = nibView.instantiateWithOwner(nil, options: nil).last as! WBRefreshView
        
        refreshView.loadImgView.hidden = true
        refreshView.loadLabel.hidden = true
        
        return refreshView
    }
    
    func startAnimation() {
        
        var rote = CGFloat(M_PI)
        
        if rotateFlag {
            rote -= 0.000001
        } else {
            rote += 0.000001
        }
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.refreshImgView.transform = CGAffineTransformRotate(self.refreshImgView.transform, rote)
        }
    }
    
    func stopAnimation() {
        
    }
}
