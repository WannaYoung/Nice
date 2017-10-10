//
//  CommonMethod.swift
//  Nice
//
//  Created by yang on 16/5/27.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit

class CommonMethod: NSObject
{
    static let shareMethod = CommonMethod()
    
    private override init(){ }
    
    func getImageSize(photoArray: [Photo],waterFlow:WaterFlowLayout) -> [CGFloat] {
        var tempArray: [CGFloat] = []
        for i in 0  ..< photoArray.count {
            let photoDict = photoArray[i]
            let temp = (ScreenWidth - waterFlow.interSpace * CGFloat(waterFlow.colNum + 1)) / CGFloat(waterFlow.colNum) / photoDict.width
            let itemHeight = photoDict.height * temp
            tempArray.append(itemHeight)
        }
        
        return tempArray

    }
    
    
    
}
