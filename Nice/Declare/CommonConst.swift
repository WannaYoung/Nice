//
//  CommonConst.swift
//  CardManager
//
//  Created by yang on 15/12/16.
//  Copyright © 2015年 yang. All rights reserved.
//
import UIKit

let APPVERSION = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]

//获取设备的物理宽度
let ScreenWidth = UIScreen.mainScreen().bounds.size.width
//获取设备的物理高度
let ScreenHeight = UIScreen.mainScreen().bounds.size.height

//主色(黄黄黄)
let MAIN_COLOR = UIColor.hexStringToColor("ffd200")
//辅助色(红色)
let ASSIST_COLOR = UIColor.hexStringToColor("fd3e25")
//背景色(浅灰色)
let BACKGROUND_COLOR = UIColor.hexStringToColor("ededed")

//主文字颜色
let MAIN_TEXT_COLOR = UIColor.hexStringToColor("222222")
//普通文字颜色
let COMMON_TEXT_COLOR = UIColor.hexStringToColor("888888")
//辅助文字颜色
let ASSIST_TEXT_COLOR = UIColor.hexStringToColor("9e9e9e")
//禁止色
let UNABLE_TEXT_COLOR = UIColor.hexStringToColor("d5d5d5")
//导航字体颜色
let NAV_TEXT_COLOR = UIColor.hexStringToColor("3b3b3b")

