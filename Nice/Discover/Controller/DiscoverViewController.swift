//
//  DiscoverViewController.swift
//  Nice
//
//  Created by yang on 16/3/18.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit
import Alamofire


class DiscoverViewController: UICollectionViewController,AoiroSoraLayoutDelegate,UICollectionViewDelegateFlowLayout
{
    let heightArray:NSMutableArray = NSMutableArray()
    
    var photoArray:Array<JSON> = []
    
    @IBOutlet weak var waterFlow: AoiroSoraLayout!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        waterFlow.interSpace = 10
        waterFlow.sectionInset = UIEdgeInsetsMake(100, 100, 100, 100)
        waterFlow.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        waterFlow.colNum = 2
        waterFlow.delegate = self
        
                
        Alamofire.request(.GET, "https://api.500px.com/v1/photos",parameters: ["consumer_key": "nv5jGhAEGAdqRKQHhDAUuVx9S90DSLdltS8hpidb","image_size": "20","only": "Wedding"]).responseJSON
            { (response) -> Void in
                let json = JSON(response.result.value!)
                self.photoArray = json["photos"].arrayValue
                self.getImageSize()
                self.collectionView?.reloadData()
                
                Alamofire.request(.GET, "https://api.500px.com/v1/photos",parameters: ["consumer_key": "nv5jGhAEGAdqRKQHhDAUuVx9S90DSLdltS8hpidb","image_size": "1080","only": "Wedding"]).responseJSON
                    { (response) -> Void in
                }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func getImageSize()
    {
        for var i = 0 ;i < photoArray.count ;i++
        {
            let photoDict = photoArray[i]
            let temp:Float = (Float(ScreenWidth) - Float(waterFlow.interSpace) * (Float(waterFlow.colNum) + 1.0)) / Float(waterFlow.colNum) / photoDict["width"].floatValue
            let itemHeight:Float = photoDict["height"].floatValue * temp
            
            let number:NSNumber = NSNumber(float: itemHeight)
            
            heightArray.addObject(number)
        }
        
        
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photoArray.count
    }
    
    func itemHeightLayOut(layOut: AoiroSoraLayout!, indexPath: NSIndexPath!) -> CGFloat
    {
        
        return CGFloat(heightArray[indexPath.row] as! NSNumber)+50
    }
    
    
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("discover", forIndexPath: indexPath)
        
        let photoDict = photoArray[indexPath.row]
        
        let pic:UIImageView = cell.viewWithTag(10) as! UIImageView
        let avator:UIImageView = cell.viewWithTag(11) as! UIImageView
        let name:UILabel = cell.viewWithTag(12) as! UILabel
        let date:UILabel = cell.viewWithTag(13) as! UILabel
        
        pic.image = nil
        avator.image = nil
        name.text = ""
        date.text = ""
        
        
        pic.kf_setImageWithURL(NSURL(string: photoDict["image_url"].stringValue)!)
        avator.kf_setImageWithURL(NSURL(string: photoDict["user"]["avatars"]["default"]["https"].stringValue)!)
        
        
        name.text = photoDict["user"]["fullname"].stringValue
        date.text = photoDict["description"].stringValue
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSizeMake(ScreenWidth, 430)
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        let reusableView:UICollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "header", forIndexPath: indexPath)
        
        
        return reusableView
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
    }

    
    
    

    
}
