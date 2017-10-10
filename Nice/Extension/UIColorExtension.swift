//
//  UIColorExtension.swift
//  MyCenter
//
//  Created by yang on 16/1/26.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func hexStringToColor(convertString:String) -> UIColor {
        
        var cString: String = convertString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.characters.count  < 6) {
            return UIColor.black
        }
        if (cString.hasPrefix("0X")) {
            cString = (cString as NSString).substring(from: 2)
        }
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        if (cString.characters.count  != 6) {
            return UIColor.black
        }
        
        var range:NSRange = NSRange()
        range.location = 0
        range.length = 2
        let rString:String = (cString as NSString).substring(with: range)
        range.location = 2
        let gString:String = (cString as NSString).substring(with: range)
        range.location = 4
        let bString:String = (cString as NSString).substring(with: range)
        
        var r:UInt32 = 0, g:UInt32 = 0, b:UInt32 = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
        
    }

}
