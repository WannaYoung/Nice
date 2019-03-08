//
//  Discovery.swift
//  Nice
//
//  Created by yang on 2017/10/10.
//  Copyright © 2017年 yang. All rights reserved.
//

import UIKit
import HandyJSON

class Discovery: HandyJSON {
    var current_page = 0
    var total_pages = 0
    var total_items = 0
    var feature = ""
    var photos: [Photo] = []
    required init() {}
}

class Photo: HandyJSON {
    var image_url = ""
    var description = ""
    var width: CGFloat = 0
    var height: CGFloat = 0
    var user: User = User()
    required init() {}
}

class User: HandyJSON {
    var fullname = ""
    var avatars: Avatars = Avatars()
    
    required init() {}
}

class Avatars: HandyJSON {
    var `default`: [String: String] = [:]
    
    required init() {}
}











