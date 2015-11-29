//
//  NetworkTool.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/17.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkDelegate {
    
    func networkToolSuccessResponse<T>(response: T, request: NSURLRequest)
    
    func networkToolFailueResponse(error: NSError, request: NSURLRequest)
}

class NetworkTool {
    
    var delegate: NetworkDelegate?
    
    //    static let sharedTools: NetworkTool = {
    //
    //        let tools = NetworkTool()
    //
    //        return tools
    //    }()
    
    func GET(url: String, parameter: [String: String]) -> NSURLRequest {
        
        let req = Alamofire.request(.GET, url, parameters: parameter).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                self.delegate?.networkToolSuccessResponse(response.result.value!, request:response.request!)
            } else {
                self.delegate?.networkToolSuccessResponse(response.result.error!, request: response.request!)
            }
        }
        
        return req.request!
    }
    
    func POST(url: String, parameter: [String: String]) -> NSURLRequest {
        
        let req = Alamofire.request(.POST, url, parameters: parameter, encoding: .URL, headers: nil).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                self.delegate?.networkToolSuccessResponse(response.result.value!, request:response.request!)
            } else {
                self.delegate?.networkToolSuccessResponse(response.result.error!, request: response.request!)
            }
        }
        
        return req.request!
    }
    
    func OAuthGET(url: String, parameter: [String: String]?) -> NSURLRequest {
        
        var tmpParameters = parameter ?? [:]
        
        if let accessTokenVaild = UserAccountViewModel.shareUserAccountViewModel.accessToken {
            tmpParameters["access_token"] = accessTokenVaild
        }
        
        return GET(url, parameter: tmpParameters)
    }
    
    func OAuthPOST(url: String, parameter: [String: String]) -> NSURLRequest {
        
        var tmpParameters = parameter
        tmpParameters["access_token"] = UserAccountViewModel.shareUserAccountViewModel.accessToken ?? ""
        
        return POST(url, parameter: tmpParameters)
    }
    
    func GETCollection<T: ResponseCollectionSerializable>(url: String, parameter: [String: String]?, itemType: T, token: Bool = true) {
        
        var tmpParameters = parameter ?? [String:String]()
        
        if let accessTokenVaild = UserAccountViewModel.shareUserAccountViewModel.accessToken {
            if token {
                tmpParameters["access_token"] = accessTokenVaild
            }
        }
        
        Alamofire.request(.GET, url, parameters: tmpParameters).responseCollection { (response: Response<[T], NSError>) -> Void in
            
            if response.result.isSuccess {
                self.delegate?.networkToolSuccessResponse(response.result.value!, request:response.request!)
            } else {
                self.delegate?.networkToolFailueResponse(response.result.error!, request: response.request!)
            }
        }
    }
}