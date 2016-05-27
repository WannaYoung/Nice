//
//  DiscoverViewController.swift
//  Nice
//
//  Created by yang on 16/3/18.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

class DiscoverViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,WaterFlowLayoutDelegate
{
    var heightArray:NSArray = NSArray()
    
    var photoArray:Array<JSON> = []
    
    @IBOutlet weak var waterFlow: WaterFlowLayout!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        waterFlow.interSpace = 10
        waterFlow.sectionInset = UIEdgeInsetsMake(100, 100, 100, 100)
        waterFlow.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        waterFlow.colNum = 2
        waterFlow.delegate = self
        
        
        WebManager.shareManager.requestWithMethod(.GET, urlString: HOME_URL, parameters: ["image_size": "20","only": "Wedding"])
        { (json, error) in
            
            self.photoArray = json["photos"].arrayValue
            self.heightArray = CommonMethod.shareMethod.getImageSize(self.photoArray, waterFlow: self.waterFlow)
            self.collectionView?.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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
    
    func itemHeightLayOut(layout:WaterFlowLayout,indexPath:NSIndexPath) -> CGFloat
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
