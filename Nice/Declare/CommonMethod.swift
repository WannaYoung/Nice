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
    
    func getImageHeight(result: SearchResult, waterFlow:WaterFlowLayout) -> CGFloat {
        let temp = (ScreenWidth - waterFlow.interSpace * CGFloat(waterFlow.colNum + 1)) / CGFloat(waterFlow.colNum) / CGFloat(result.width)
        let itemHeight = CGFloat(result.height) * temp
        return itemHeight
    }
    
    
    
}
