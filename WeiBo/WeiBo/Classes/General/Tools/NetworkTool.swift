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
    
    func networkToolSuccessResponse(response: AnyObject, request: NSURLRequest)
    
    func networkToolFailueResponse(error: NSError, request: NSURLRequest)
}

class NetworkTool {
    
    var delegate: NetworkDelegate?
    
    static let sharedTools: NetworkTool = {
        
        let tools = NetworkTool()
        
        return tools
    }()
    
    class func GET(url: String, parameter: [String: String]) -> NSURLRequest {
        
        let req = Alamofire.request(.GET, url, parameters: parameter, encoding: .URL, headers: nil).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                sharedTools.delegate?.networkToolSuccessResponse(response.result.value!, request:response.request!)
            } else {
                sharedTools.delegate?.networkToolSuccessResponse(response.result.error!, request: response.request!)
            }
        }
        
        return req.request!
    }
    
    class func POST(url: String, parameter: [String: String]) -> NSURLRequest {
        
        let req = Alamofire.request(.POST, url, parameters: parameter, encoding: .URL, headers: nil).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                sharedTools.delegate?.networkToolSuccessResponse(response.result.value!, request:response.request!)
            } else {
                sharedTools.delegate?.networkToolSuccessResponse(response.result.error!, request: response.request!)
            }
        }
        
        return req.request!
    }
}