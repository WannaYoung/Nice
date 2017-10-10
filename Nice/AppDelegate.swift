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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.configAppUI()
        
        return true
    }
    
    func configAppUI() {
        
        self.window!.backgroundColor = UIColor.white
        
        //表视图背景色
        UITableView.appearance().backgroundColor = BACKGROUND_COLOR
        
        //返回按钮
        let image:UIImage = UIImage(named: "goback")!
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        var offset:UIOffset = UIOffset.zero
        offset.horizontal = -500
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(offset, for: UIBarMetrics.default)
        
        //导航栏风格
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: NAV_TEXT_COLOR, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18.0)]
        UINavigationBar.appearance().barTintColor = UIColor.white
        
        //Tabbar风格
        UITabBar.appearance().tintColor = MAIN_COLOR
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: COMMON_TEXT_COLOR], for: UIControlState.selected)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

