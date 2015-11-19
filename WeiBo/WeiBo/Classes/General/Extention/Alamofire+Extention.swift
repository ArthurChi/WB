//
//  Alamofire+Extention.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/19.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import Foundation
import Alamofire

public protocol ResponseCollectionSerializable {
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Self]
}

extension Alamofire.Request {
    
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler:Response<[T], NSError> -> Void) -> Self {
        
        let serializer: ResponseSerializer<[T], NSError> = ResponseSerializer { (request, response, data, error) in
            
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments).serializeResponse(request, response, data, error)
            
            if let JSON = JSONSerializer.value {
                
                return Result.Success(T.collection(response: response!, representation: JSON))
            } else {
                return Result.Failure(error!)
            }
        }
        
        return response(responseSerializer: serializer, completionHandler: completionHandler)
    }
}