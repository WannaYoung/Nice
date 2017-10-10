//
//  TabViewController.swift
//  Nice
//
//  Created by yang on 16/3/18.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupTabbar()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
    func setupTabbar()
    {
        
        let customView:UIView = UIView(frame:CGRect(x: ScreenWidth/5*2, y: 0, width: ScreenWidth/5, height: tabBar.frame.size.height) )
                
        customView.backgroundColor = UIColor.clear
        
        let cameraBT:UIButton = UIButton(type: UIButtonType.custom)
        
        cameraBT.setImage(UIImage(named: "tabbar_Camera_icon"), for: UIControlState.normal)
        
        cameraBT.frame = CGRect(x: 0, y: 0, width: customView.frame.size.width, height: customView.frame.size.height)
        
        cameraBT.addTarget(self, action: #selector(TabViewController.openCamera), for: UIControlEvents.touchUpInside)

        customView.addSubview(cameraBT)
        
        tabBar.addSubview(customView)
    }
    
    @objc func openCamera()
    {
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        
        var sourceType = UIImagePickerControllerSourceType.camera
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        let picker:UIImagePickerController = UIImagePickerController()
        
        picker.delegate = self
        
        picker.allowsEditing = true
        
        picker.sourceType = sourceType
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}


