//
//  CommonMethod.swift
//  Nice
//
//  Created by yang on 16/5/27.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommonMethod: NSObject
{
    static let shareMethod = CommonMethod()
    
    private override init(){ }
    
    func getImageSize(photoArray:Array<JSON>,waterFlow:WaterFlowLayout) -> NSArray
    {
        let tempArray:NSMutableArray = NSMutableArray()

        for i in 0  ..< photoArray.count
        {
            let photoDict = photoArray[i]
            let temp:Float = (Float(ScreenWidth) - Float(waterFlow.interSpace) * (Float(waterFlow.colNum) + 1.0)) / Float(waterFlow.colNum) / photoDict["width"].floatValue
            let itemHeight:Float = photoDict["height"].floatValue * temp
            let number:NSNumber = NSNumber(float: itemHeight)
            
            tempArray.addObject(number)
            
        }
        
        return tempArray.copy() as! NSArray

    }
    
    
    
}