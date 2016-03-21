//
//  UIColorExtension.swift
//  MyCenter
//
//  Created by yang on 16/1/26.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit

extension UIColor
{
    class func hexStringToColor(convertString:String) -> UIColor
    {
        var cString:String = convertString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.characters.count  < 6)
        {
            return UIColor.blackColor()
        }
        if (cString.hasPrefix("0X"))
        {
            cString = (cString as NSString).substringFromIndex(2)
        }
        if (cString.hasPrefix("#"))
        {
            cString = (cString as NSString).substringFromIndex(1)
        }
        if (cString.characters.count  != 6)
        {
            return UIColor.blackColor()
        }
        
        var range:NSRange = NSRange()
        range.location = 0
        range.length = 2
        let rString:String = (cString as NSString).substringWithRange(range)
        range.location = 2
        let gString:String = (cString as NSString).substringWithRange(range)
        range.location = 4
        let bString:String = (cString as NSString).substringWithRange(range)
        
        var r:UInt32 = 0, g:UInt32 = 0, b:UInt32 = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
        
    }

}