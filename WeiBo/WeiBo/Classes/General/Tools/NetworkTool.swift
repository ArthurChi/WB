//
//  NetworkTool.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/17.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import Foundation
import Alamofire

class NetworkTool {
    
    private let appKey = "1126083890"
    private let appSecrt = "3e1d1a205cb27b2c9bd59f85396e308f"
    private let redictUrl = "http://www.baidu.com"
    private let OAuthUrl = "https://api.weibo.com/oauth2/authorize"
    
    static let sharedTools: NetworkTool = {
        
        let tools = NetworkTool()
        
        return tools
    }()
    
    class func GET(url: String, parameter: [String: String], finish: () -> ()) {
        
        Alamofire.request(.GET, url, parameters: parameter, encoding: .URL, headers: nil).responseJSON { (response) -> Void in
            
            print(response)
        }
    }
    
    class func POST(url: String, parameter: [String: String], finish: (AnyObject) -> ()) {
        
        Alamofire.request(.POST, url, parameters: parameter, encoding: .URL, headers: nil).responseJSON { (response) -> Void in
            
            finish(response.result.value!)
        }
    }
}

// MARK: - OAuth
extension NetworkTool {
    
    var oauthUrl: NSURL {
        
        let urlStr = "\(OAuthUrl)?client_id=\(appKey)&redirect_uri=\(redictUrl)"
        
        return NSURL(string: urlStr)!
    }
    
    func AccessTocken(code: String) {
        
        let parameters =  ["client_id": appKey, "client_secret": appSecrt, "grant_type": "authorization_code", "code": code, "redirect_uri": redictUrl]
        
        NetworkTool.POST("https://api.weibo.com/oauth2/access_token", parameter:parameters) { (response) -> () in
            
            
        }
    }
    
}