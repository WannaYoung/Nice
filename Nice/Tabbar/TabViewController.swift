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
        let customView:UIView = UIView(frame:CGRectMake(ScreenWidth/5*2, 0, ScreenWidth/5, tabBar.frame.size.height) )
                
        customView.backgroundColor = UIColor.clearColor()
        
        let cameraBT:UIButton = UIButton(type: UIButtonType.Custom)
        
        cameraBT.setImage(UIImage(named: "tabbar_Camera_icon"), forState: UIControlState.Normal)
        
        cameraBT.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height)
        
        cameraBT.addTarget(self, action: "openCamera", forControlEvents: UIControlEvents.TouchUpInside)

        customView.addSubview(cameraBT)
        
        tabBar.addSubview(customView)
    }
    
    func openCamera()
    {
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        
        var sourceType = UIImagePickerControllerSourceType.Camera
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        let picker:UIImagePickerController = UIImagePickerController()
        
        picker.delegate = self
        
        picker.allowsEditing = true
        
        picker.sourceType = sourceType
        
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}


