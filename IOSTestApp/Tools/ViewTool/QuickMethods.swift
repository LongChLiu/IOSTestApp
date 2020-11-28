//
//  QuickMethods.swift
//  WXFilmClient
//
//  Created by 刘隆昌 on 2020/8/25.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import Foundation
import UIKit

typealias GeneralBlock = () -> Void

/**设备判断(手机/平板/视网膜屏)*/
var isIPad: Bool {
    return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
}

var isIphone: Bool {
    return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
}

var isRetina: Bool {
    return UIScreen.main.scale >= 2.0
}

/**屏幕宽高*/
let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height

let scaleDevice: CGFloat = UIScreen.main.scale

var kScreenWidth: CGFloat {
    return min(width, height)
}

var kScreenHeight: CGFloat {
    return max(width, height)
}

/** 判断是否为iPhone X 系列或以上 这样写消除了在Xcode10上的警告*/
var isiPhoneX: Bool {
    let screenHeight = UIScreen.main.nativeBounds.size.height
    if screenHeight == 2436 || screenHeight == 1792 || screenHeight == 2688 || screenHeight == 1624 {
        return true
    }
    return false
}

/**状态栏高度*/
var kStatusBarHeight: CGFloat {
    return isiPhoneX ? 44.0 : 20.0
}

/**状态栏+导航栏高度*/
var kStatusPlusNavBarHeight: CGFloat {
    return isiPhoneX ? 88.0:64.0
}

/**TabBar高度*/
var kTabBarHeight: CGFloat {
    return isiPhoneX ? 83.0 : 49.0
}

/**顶部安全区域远离高度*/
var kTopBarSafeHeight: CGFloat {
    return isiPhoneX ? 44.0 : 0.0
}

/**底部安全区域远离高度*/
var kBottomSafeHeight: CGFloat {
    return isiPhoneX ? 34.0 : 0.0
}

func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

///配置宽高比例(以iPhone6为准)
let widthScale: CGFloat = kScreenWidth / 375.0
let heightScale: CGFloat = kScreenHeight / 667.0

func kStrIsEmpty(_ str: String?) -> Bool {
    if let xstr = str, xstr != "" {
        return false
    } else {
        return true
    }
}

@objc public class Stoc: NSObject {
    @objc static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    @objc static func setWidthScale(_ point: CGFloat) -> CGFloat {
        return point * widthScale
    }
    @objc static func setHeightScale(_ point: CGFloat) -> CGFloat {
        return point * heightScale
    }
    @objc static func kStrIsEmpty(_ str: String?) -> Bool {
        if let xstr = str, xstr != "" {
            return false
        } else {
            return true
        }
    }
}

extension CGRect {
    static func `init`(_ xOrgin: CGFloat, _ yOrgin: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect.init(x: xOrgin, y: yOrgin, width: width, height: height)
    }
}

extension UIColor {
    static func `init`(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}

func UIColorRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor {
    return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

func anImg(_ name: String) -> UIImage {
    return UIImage.init(named: name) ?? UIImage()
}

func fontMediumSize(_ size: CGFloat) -> UIFont? {
    return UIFont.init(name: "PingFangSC-Medium", size: size)
}

func fontRegularSize(_ size: CGFloat) -> UIFont? {
    return UIFont.init(name: "PingFangSC-Regular", size: size)
}

func fontHeavySize(_ size: CGFloat) -> UIFont? {
    return UIFont.init(name: "Helvetica-Bold", size: size)
}

func fontBoldSize(_ size: CGFloat) -> UIFont? {
    return UIFont.boldSystemFont(ofSize: size)
}

func fontSystemSize(_ size: CGFloat) -> UIFont? {
    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
}
