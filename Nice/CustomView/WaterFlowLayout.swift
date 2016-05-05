//
//  WaterFlowLayout.swift
//  PhotoBrower
//
//  Created by yang on 16/2/15.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit


protocol WaterFlowLayoutDelegate
{
    func itemHeightLayOut(layout:WaterFlowLayout,indexPath:NSIndexPath) -> CGFloat
}

class WaterFlowLayout: UICollectionViewFlowLayout
{
    var colNum:NSInteger = 2
    var interSpace:CGFloat = 5
    var edgeInsets:UIEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
    
    var columHeightArray:NSMutableArray = NSMutableArray()
    var attributeArray:NSMutableArray = NSMutableArray()
    
    var delegate:WaterFlowLayoutDelegate?
    
    
    override func prepareLayout()
    {
        columHeightArray = NSMutableArray(capacity: colNum)
        
        for index in 0  ..< colNum
        {
            columHeightArray[index] = edgeInsets.top
        }
        //从总宽度
        let totalWidth:CGFloat = self.collectionView!.bounds.size.width
        //每行所有的item
        let totalItemWidth:CGFloat = totalWidth - edgeInsets.left - edgeInsets.right - interSpace * CGFloat(colNum-1)
        //每个item
        let itemwidth:CGFloat = totalItemWidth / CGFloat(colNum)        //拿到每个分区所有item的个数
        let totalItems:NSInteger = (self.collectionView?.numberOfItemsInSection(0))!
        
        for i in 0  ..< totalItems
        {
            let currentCol:NSInteger = self.minCuttentCol()
            
            let xPos:CGFloat = edgeInsets.left + (itemwidth + interSpace) * CGFloat(currentCol)
            let yPos:CGFloat = CGFloat(columHeightArray[currentCol] as! NSNumber)
            
            let indexPath:NSIndexPath = NSIndexPath(forItem: i, inSection: 0)
            var itemHeight:CGFloat = 0.0
            
            itemHeight = (delegate?.itemHeightLayOut(self, indexPath: indexPath))!
            let frame:CGRect = CGRectMake(xPos, yPos, itemwidth, itemHeight)
            let attribute:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attribute.frame = frame
            attributeArray.addObject(attribute)
            let upDateY:CGFloat = CGFloat(columHeightArray[currentCol] as! NSNumber) + itemHeight + interSpace
            columHeightArray[currentCol] = upDateY
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        var resultArray = [UICollectionViewLayoutAttributes]()
        
        for attributes in attributeArray
        {
            let rect1:CGRect = (attributes as! UICollectionViewLayoutAttributes).frame
            if(CGRectIntersectsRect(rect1, rect))
            {
                resultArray.append(attributes as! UICollectionViewLayoutAttributes)
            }
            
        }
        return resultArray
    }
    
    override func collectionViewContentSize() -> CGSize
    {
        let width:CGFloat = self.collectionView!.frame.size.width
        let index:NSInteger = self.maxCuttentCol()
        let height:CGFloat = CGFloat(columHeightArray[index] as! NSNumber)
        return CGSizeMake(width, height)
    }
    
    func configColNum(number:NSInteger)
    {
        if (colNum != number)
        {
            colNum = number
            self.invalidateLayout()
        }
    
    }
    
    func configInterSpace(space:CGFloat)
    {
        if (interSpace != space)
        {
            interSpace = space
            self.invalidateLayout()
        }
    }
    
    func configEdgeInsets(edge:UIEdgeInsets)
    {
        if (!UIEdgeInsetsEqualToEdgeInsets(edgeInsets, edge))
        {
            edgeInsets = edge
            self.invalidateLayout()
        }
    }
    
    
    func maxCuttentCol() -> NSInteger
    {
       var maxHeight:CGFloat = 0.0
       var maxIndex:NSInteger = 0
        
        for (index, _) in columHeightArray.enumerate()
        {
            let heightInArray:CGFloat = CGFloat(columHeightArray[index] as! NSNumber)
            if (heightInArray > maxHeight)
            {
                maxHeight = heightInArray
                maxIndex = index
            }
        }
        return maxIndex
        
    
    }
    
    //每次取最小y的列
    func minCuttentCol() -> NSInteger
    {
        var minHeight:CGFloat = CGFloat(MAXFLOAT)
        var minIndex:NSInteger = 0
        
        for (index, _) in columHeightArray.enumerate()
        {
            let heightInArray:CGFloat = CGFloat(columHeightArray[index] as! NSNumber)
            if (heightInArray < minHeight)
            {
                minHeight = heightInArray
                minIndex = index
            }
        }
        return minIndex
    }
   

}
