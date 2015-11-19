//
//  UserAccountViewModel.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/18.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import Foundation

class UserAccountViewModel: NetworkDelegate {
    
    private let appKey = "1126083890"
    private let appSecrt = "3e1d1a205cb27b2c9bd59f85396e308f"
    private let redictUrl = "http://www.baidu.com"
    private let OAuthUrl = "https://api.weibo.com/oauth2/authorize"
    
    // 用户
    var userAccount: UserAccount?
    /// 完成后回调
    private var finishBlock: ((Bool)->())?
    // tocken的请求
    private var accessTockenRequest: NSURLRequest?
    // 用户信息的请求
    private var userInfoRequest: NSURLRequest?
    
    static let shareUserAccountViewModel = UserAccountViewModel()
    
    // 存储路径
    var savePath: String {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        
        return (path as NSString).stringByAppendingPathComponent("account.plist")
    }
    
    /// 判断是否过期
    private var isExpired: Bool {
        
        if userAccount?.expiresDate?.compare(NSDate()) == NSComparisonResult.OrderedDescending {
            
            return false
        }
        
        return true
    }
    
    var accessToken: String? {
        
        if isExpired {
            
            return nil
        }
        
        return userAccount?.access_token
    }
    
    /// 是否过期
    var loginFlag: Bool {
        
        return userAccount?.access_token != nil && !isExpired
    }
    
    // 头像URL
    var avatarLargeUrl: NSURL {
        
        return NSURL(string: userAccount?.avatar_large ?? "")!
    }
    
    private init() {
        
        userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(savePath) as? UserAccount
        
        if isExpired {
            
            userAccount = nil
        }
    }
    
    func loadAccessToken(code: String, finish:(success: Bool)->()) {
        
        NetworkTool.sharedTools.delegate = self
        accessTockenRequest = reqAccessTocken(code)
        finishBlock = finish
    }
    
    // MARK: - NetworkToolDelegate
    func networkToolSuccessResponse<T>(response: T, request: NSURLRequest) {
        guard let responseVaild = response as? [String: AnyObject] else { // 格式错误
            
            return
        }
        
        if request == accessTockenRequest {
            userAccount = UserAccount(dict: responseVaild)
            // 获得tocken后, 请求用户信息
            userInfoRequest = reqUserInfo()
            
        } else if request == userInfoRequest { // 获取到用户信息
            finishBlock!(true)
            
            userAccount?.screen_name = responseVaild["screen_name"] as? String
            userAccount?.avatar_large = responseVaild["avatar_large"] as? String
            
            // 持久化
            NSKeyedArchiver.archiveRootObject(userAccount!, toFile: savePath)
        }
        
    }
    
    @objc func networkToolFailueResponse(error: NSError, request: NSURLRequest) {
        finishBlock!(false)
    }
}

// MARK: - NetWork
extension UserAccountViewModel {
    
    var oauthUrl: NSURL {
        
        let urlStr = "\(OAuthUrl)?client_id=\(appKey)&redirect_uri=\(redictUrl)"
        
        return NSURL(string: urlStr)!
    }
    
    func reqAccessTocken(code: String) -> NSURLRequest {
        
        let parameters =  ["client_id": appKey, "client_secret": appSecrt, "grant_type": "authorization_code", "code": code, "redirect_uri": redictUrl]
        
        return NetworkTool.POST("https://api.weibo.com/oauth2/access_token", parameter:parameters)
    }
    
    func reqUserInfo() -> NSURLRequest {
        
        let prarmeters = ["access_token": userAccount!.access_token!, "uid": userAccount!.uid!]
        return NetworkTool.GET("https://api.weibo.com/2/users/show.json", parameter: prarmeters)
    }
}