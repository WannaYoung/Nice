//
//  WebManager.swift
//  Nice
//
//  Created by yang on 16/5/27.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit
import Networking
import HandyJSON

class WebManager: NSObject {
    
    static let share = WebManager()
    private override init(){ }
    
    //MARK: - Http GET Method
    func getDataWith<T: HandyJSON>(path: String, parama: [String: String], successHandler: @escaping (T) -> Swift.Void, failureHandler: ((NSError) -> Swift.Void)? = nil) {
        
        var vParama = parama
        vParama["consumer_key"] = CONSUMER_KEY
        let networking = Networking(baseURL: HOMEURL)
        networking.get(path, parameters: vParama ) { (result) in
            switch result {
            case .success(let successResponse):
                if let getData = T.deserialize(from: successResponse.dictionaryBody) {
                    successHandler(getData)
                }
                break
            case .failure(let failureResponse):
                failureHandler?(failureResponse.error)
                break
            }
        }
    }
}

