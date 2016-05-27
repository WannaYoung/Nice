//
//  WebManager.swift
//  Nice
//
//  Created by yang on 16/5/27.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WebManager: NSObject
{
    static let shareManager = WebManager()
    
    private override init(){ }

    func requestWithMethod(method:Alamofire.Method,urlString:String,parameters:NSDictionary,completionHandler:(JSON!,NSError!) -> Void)
    {
        let tempDict:NSMutableDictionary = parameters.mutableCopy() as! NSMutableDictionary
        tempDict.setObject(CONSUMER_KEY, forKey: "consumer_key")
        let para: [String : AnyObject] = tempDict.copy() as! [String : AnyObject]
        
        Alamofire.request(method, urlString,parameters: para).responseJSON
            { (response) -> Void in
                
                let json = JSON(response.result.value!)
                
                completionHandler(json,response.result.error)
                
            }
    }

    
    
}
