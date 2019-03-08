//
//  DiscoverViewController.swift
//  Nice
//
//  Created by yang on 16/3/18.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,WaterFlowLayoutDelegate
{
    var unsplashSearch = UnsplashSearch()
    
    @IBOutlet weak var waterFlow: WaterFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        initWaterFlow()
        getDiscoveryPhotos()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initWaterFlow() {
        waterFlow.interSpace = 10
        waterFlow.sectionInset = UIEdgeInsetsMake(100, 100, 100, 100)
        waterFlow.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        waterFlow.colNum = 2
        waterFlow.delegate = self
    }
    
    func getDiscoveryPhotos() {
        WebManager.share.getDataWith(path: PHOTOAPI, parama: ["client_id": CONSUMER_KEY, "query": "love", "page": "1", "per_page": "10", "orientation": "portrait"], successHandler: { (search: UnsplashSearch) in
            self.unsplashSearch = search
            self.collectionView?.reloadData()
        }) { (error) in
            
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return unsplashSearch.results.count
    }
    
    func itemHeightLayOut(layout:WaterFlowLayout,indexPath:IndexPath) -> CGFloat {
        return CommonMethod.shareMethod.getImageHeight(result: unsplashSearch.results[indexPath.row], waterFlow: waterFlow)+50
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let result = unsplashSearch.results[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "discover", for: indexPath)
        
        let pic:UIImageView = cell.viewWithTag(10) as! UIImageView
        let avator:UIImageView = cell.viewWithTag(11) as! UIImageView
        let name:UILabel = cell.viewWithTag(12) as! UILabel
        let date:UILabel = cell.viewWithTag(13) as! UILabel
        pic.image = nil
        avator.image = nil
        name.text = ""
        date.text = ""
        
        let endIndex = result.created_at.index(result.created_at.startIndex, offsetBy: 10)
        
        pic.kf.setImage(with: URL(string: result.urls.small))
        avator.kf.setImage(with: URL(string: result.user.profile_image.medium))
        name.text = result.user.name
        date.text = String(result.created_at[result.created_at.startIndex..<endIndex])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: ScreenWidth, height: 430)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView:UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        
        return reusableView
    }

}
