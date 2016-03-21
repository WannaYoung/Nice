//
//  AppDelegate.swift
//  Nice
//
//  Created by yang on 16/3/18.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        self.configAppUI()
        
        return true
    }
    
    func configAppUI()
    {
        self.window!.backgroundColor = UIColor.whiteColor()
        
        //表视图背景色
        UITableView.appearance().backgroundColor = BACKGROUND_COLOR
        
        //返回按钮
        let image:UIImage = UIImage(named: "goback")!
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        var offset:UIOffset = UIOffsetZero
        offset.horizontal = -500;
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(offset, forBarMetrics: UIBarMetrics.Default)
        
        //导航栏风格
        UINavigationBar.appearance().translucent = true
        UINavigationBar.appearance().titleTextAttributes = NSDictionary(objects: [NAV_TEXT_COLOR,UIFont.systemFontOfSize(18.0)], forKeys: [NSForegroundColorAttributeName,NSFontAttributeName]) as? [String : AnyObject]
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        
//        Tabbar风格
        UITabBar.appearance().tintColor = MAIN_COLOR
        
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(objects: [COMMON_TEXT_COLOR], forKeys: [NSForegroundColorAttributeName]) as? [String : AnyObject], forState: UIControlState.Selected)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

