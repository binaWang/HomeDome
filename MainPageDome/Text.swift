//
//  Text.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/2.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

public extension UIFont {
    
 
    


    class func initializeMethod() {
        let originalSelector = #selector(UIFont.systemFont(ofSize:))
        let swizzledSelector = #selector(UIFont.adaptFont(fontSize:))
        if let originalMethod = class_getClassMethod(UIFont.self, originalSelector), let swizzledMethod = class_getClassMethod(UIFont.self, swizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }

        //平方
        let nameOriginalSelector = #selector(UIFont.pingFangSC_Regular(ofSize:))
        let nameSwizzledSelector = #selector(UIFont.svwPingFangSC_Regular(ofSize:))
        if let originalMethod = class_getClassMethod(UIFont.self, nameOriginalSelector), let swizzledMethod = class_getClassMethod(UIFont.self, nameSwizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }

        //加中粗
        let mediumOriginalSelector = #selector(UIFont.pingFangSC_Medium(ofSize:))
        let mediumSwizzledSelector = #selector(UIFont.svwPingFangSC_Medium(ofSize:))
        if let originalMethod = class_getClassMethod(UIFont.self, mediumOriginalSelector), let swizzledMethod = class_getClassMethod(UIFont.self, mediumSwizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }

        //加粗
        let semiboldOriginalSelector = #selector(UIFont.pingFangSC_Semibold(ofSize:))
        let semiboldSwizzledSelector = #selector(UIFont.svwPingFangSC_Semibold(ofSize:))
        if let originalMethod = class_getClassMethod(UIFont.self, semiboldOriginalSelector), let swizzledMethod = class_getClassMethod(UIFont.self, semiboldSwizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        
        
        //VWText字体库
        let vwRegularOriginalSelector = #selector(UIFont.vwText_Regular(ofSize:))
        let vwRegularSwizzledSelector = #selector(UIFont.svw_vwText_Regular(ofSize:))
        if let originalMethod = class_getClassMethod(UIFont.self, vwRegularOriginalSelector), let swizzledMethod = class_getClassMethod(UIFont.self, vwRegularSwizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        
        //VWText字体库
        let vwLightOriginalSelector = #selector(UIFont.vwText_Light(ofSize:))
        let vwLightSwizzledSelector = #selector(UIFont.svw_vwText_Light(ofSize:))
        if let originalMethod = class_getClassMethod(UIFont.self, vwLightOriginalSelector), let swizzledMethod = class_getClassMethod(UIFont.self, vwLightSwizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        
        //VWText字体库
        let vwBoldOriginalSelector = #selector(UIFont.vwText_Bold(ofSize:))
        let vwBoldSwizzledSelector = #selector(UIFont.svw_vwText_Bold(ofSize:))
        if let originalMethod = class_getClassMethod(UIFont.self, vwBoldOriginalSelector), let swizzledMethod = class_getClassMethod(UIFont.self, vwBoldSwizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }

        //针对UILabel XIB/SB 做字体适配
        UILabel.initializeMethod()
    }

    @objc class func adaptFont(fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "HYQiHei-FZS", size: fontSize * kScale) {
            return font
        }
        let newFont = UIFont.adaptFont(fontSize: fontSize * kScale)
        return newFont
    }

    //HYQiHei-40S HYQiHei-DZS
    @objc class func svwPingFangSC_Regular(ofSize size: CGFloat) -> UIFont?
    {
        //HYQiHei-40S HYQiHei-DZS字体太细，客户要求最细使用HYQiHei-60S HYQiHei-FZS
        let newFont = UIFont(name: "HYQiHei-FZS", size: size * kScale)
        return newFont
    }

    //HYQiHei-60S HYQiHei-FZS
    @objc class func svwPingFangSC_Medium(ofSize size: CGFloat) -> UIFont?
    {
        let newFont = UIFont(name: "HYQiHei-FZS", size: size * kScale)
        return newFont
    }

    //HYQiHei-80S HYQiHei-HZS
    @objc class func svwPingFangSC_Semibold(ofSize size: CGFloat) -> UIFont?
    {
        let newFont = UIFont(name: "HYQiHei-HZS", size: size * kScale)
        return newFont
    }
    
    //VWText字体库
    @objc class func svw_vwText_Regular(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "VWText", size: size * kScale)
    }
    
    @objc class func svw_vwText_Light(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "VWText-Light", size: size * kScale)
    }
    
    @objc class func svw_vwText_Bold(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "VWText-Bold", size: size * kScale)
    }
    
    func fontRefAndSize()->(CFTypeRef,CGFloat) {
        let fontRef = CGFont.init(self.fontName as CFString)!
        return (fontRef,self.pointSize )
    }
    
    
    ///ArialMT
    class func arialMT(ofSize size: CGFloat) -> UIFont?
    {
        return UIFont(name: "ArialMT", size: size)
    }
    
    /// Medium
    class var arialMT_45: UIFont {
        return arialMT(ofSize: 45) ?? .systemFont(ofSize: 45)
    }
    
    /// 平方字体
    @objc class func pingFangSC_Medium(ofSize size: CGFloat) -> UIFont?
    {
        return UIFont(name: "PingFangSC-Medium", size: size)
    }
    
    @objc class func pingFangSC_Regular(ofSize size: CGFloat) -> UIFont?
    {
        return UIFont(name: "PingFangSC-Regular", size: size)
    }
    
    @objc class func pingFangSC_Semibold(ofSize size: CGFloat) -> UIFont?
    {
        return UIFont(name: "PingFangSC-Semibold", size: size)
    }
    
    class func pingFangSC_Thin(ofSize size: CGFloat) -> UIFont?
    {
        return UIFont(name: "PingFangSC-Thin", size: size)
    }
    
    class func DIN_Medium(ofSize size: CGFloat) -> UIFont?
    {
        return UIFont(name: "Helvetica Neue", size: size)
    }

    //VWText字体库
    @objc class func vwText_Regular(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "VWText", size: size)
    }

    @objc class func vwText_Light(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "VWText-Light", size: size)
    }

    @objc class func vwText_Bold(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "VWText-Bold", size: size)
    }

    ///...
    class var app_bigNumber_font: UIFont {
        return UIFont.boldSystemFont(ofSize: 45)
    }
    
    class var app_middle_font: UIFont {
        return UIFont.boldSystemFont(ofSize: 31)
    }
    
    /// Medium
    class var pingFangSC_Medium_30: UIFont {
        return pingFangSC_Medium(ofSize: 30) ?? .systemFont(ofSize: 30)
    }
    
    class var pingFangSC_Medium_27: UIFont {
        return pingFangSC_Medium(ofSize: 27) ?? .systemFont(ofSize: 27)
    }
    
    class var pingFangSC_Medium_24: UIFont {
        return pingFangSC_Medium(ofSize: 24) ?? .systemFont(ofSize: 24)
    }
    
    class var pingFangSC_Medium_22: UIFont {
        return pingFangSC_Medium(ofSize: 22) ?? .systemFont(ofSize: 22)
    }

    class var pingFangSC_Medium_20: UIFont {
        return pingFangSC_Medium(ofSize: 20) ?? .systemFont(ofSize: 20)
    }
    
    class var pingFangSC_Medium_19: UIFont {
        return pingFangSC_Medium(ofSize: 19) ?? .systemFont(ofSize: 19)
    }
    
    class var pingFangSC_Medium_18: UIFont {
        return pingFangSC_Medium(ofSize: 18) ?? .systemFont(ofSize: 18)
    }
    
    class var pingFangSC_Medium_17: UIFont {
        return pingFangSC_Medium(ofSize: 17) ?? .systemFont(ofSize: 17)
    }
    
    class var pingFangSC_Medium_16: UIFont {
        return pingFangSC_Medium(ofSize: 16) ?? .systemFont(ofSize: 16)
    }
    
    class var pingFangSC_Medium_15: UIFont {
        return pingFangSC_Medium(ofSize: 15) ?? .systemFont(ofSize: 15)
    }
    
    class var pingFangSC_Medium_14: UIFont {
        return pingFangSC_Medium(ofSize: 14) ?? .systemFont(ofSize: 14)
    }
    
    class var pingFangSC_Medium_13: UIFont {
        return pingFangSC_Medium(ofSize: 13) ?? .systemFont(ofSize: 13)
    }
    
    class var pingFangSC_Medium_12: UIFont {
        return pingFangSC_Medium(ofSize: 12) ?? .systemFont(ofSize: 12)
    }
    
    class var pingFangSC_Medium_11: UIFont {
        return pingFangSC_Medium(ofSize: 11) ?? .systemFont(ofSize: 11)
    }

    class var pingFangSC_Medium_10: UIFont {
        return pingFangSC_Medium(ofSize: 10) ?? .systemFont(ofSize: 10)
    }
    
    /// Semibold
    class var pingFangSC_Semibold_21: UIFont {
        return pingFangSC_Semibold(ofSize: 21) ?? UIFont.boldSystemFont(ofSize: 21)
    }

    class var pingFangSC_Semibold_18: UIFont {
        return pingFangSC_Semibold(ofSize: 18) ?? UIFont.boldSystemFont(ofSize: 18)
    }
    
    class var pingFangSC_Semibold_19: UIFont {
        return pingFangSC_Semibold(ofSize: 19) ?? UIFont.boldSystemFont(ofSize: 19)
    }
    
    class var pingFangSC_Semibold_16: UIFont {
        return pingFangSC_Semibold(ofSize: 16) ?? UIFont.boldSystemFont(ofSize: 16)
    }
    
    class var pingFangSC_Semibold_12: UIFont {
        return pingFangSC_Semibold(ofSize: 12) ?? UIFont.boldSystemFont(ofSize: 12)
    }

    class var pingFangSC_Semibold_24: UIFont {
        return pingFangSC_Semibold(ofSize: 24) ?? UIFont.boldSystemFont(ofSize: 24)
    }
    
    /// Regular
    class var pingFangSC_Regular_20: UIFont {
        return pingFangSC_Regular(ofSize: 20) ?? UIFont.systemFont(ofSize: 20)
    }
    
    class var pingFangSC_Regular_19: UIFont {
        return pingFangSC_Regular(ofSize: 19) ?? UIFont.systemFont(ofSize: 19)
    }
    
    class var pingFangSC_Regular_17: UIFont {
        return pingFangSC_Regular(ofSize: 17) ?? UIFont.boldSystemFont(ofSize: 17)
    }
    
    class var pingFangSC_Regular_16: UIFont {
        return pingFangSC_Regular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16)
    }
    
    class var pingFangSC_Regular_15: UIFont {
        return pingFangSC_Regular(ofSize: 15) ?? UIFont.systemFont(ofSize: 15)
    }
    
    class var pingFangSC_Regular_14: UIFont {
        return pingFangSC_Regular(ofSize: 14) ?? UIFont.systemFont(ofSize: 14)
    }
    
    class var pingFangSC_Regular_13: UIFont {
        return pingFangSC_Regular(ofSize: 13) ?? UIFont.systemFont(ofSize: 13)
    }
    
    class var pingFangSC_Regular_12: UIFont {
        return pingFangSC_Regular(ofSize: 12) ?? UIFont.systemFont(ofSize: 12)
    }
    
    class var pingFangSC_Regular_11: UIFont {
        return pingFangSC_Regular(ofSize: 11) ?? UIFont.systemFont(ofSize: 11)
    }
    
    class var pingFangSC_Regular_10: UIFont {
        return pingFangSC_Regular(ofSize: 10) ?? UIFont.systemFont(ofSize: 10)
    }
    
    class var pingFangSC_Regular_9: UIFont {
        return pingFangSC_Regular(ofSize: 9) ?? UIFont.systemFont(ofSize: 9)
    }
    
    class var DIN_Medium_12: UIFont {
        return DIN_Medium(ofSize: 12) ?? UIFont.systemFont(ofSize: 12)
    }
    
    class var DIN_Medium_18: UIFont {
        return DIN_Medium(ofSize: 18) ?? UIFont.systemFont(ofSize: 18)
    }
    
    class var DIN_Medium_20: UIFont {
        return DIN_Medium(ofSize: 20) ?? UIFont.systemFont(ofSize: 20)
    }
    
}

fileprivate extension UILabel {
    class func initializeMethod() {
        let originalSelector = #selector(UILabel.init(coder:))
        let swizzledSelector = #selector(UILabel.svwInit(coder:))
        if let originalMethod = class_getInstanceMethod(UILabel.self, originalSelector), let swizzledMethod = class_getInstanceMethod(UILabel.self, swizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }

    @objc func svwInit(coder: NSCoder) {
        self.svwInit(coder: coder)
        let fontSize = self.font.pointSize
        self.font = UIFont.systemFont(ofSize: fontSize * kScale)
    }
}
//适配scale
fileprivate let kScale = (UIScreen.main.bounds.size.width / 375 <= 1) ? UIScreen.main.bounds.size.width / 375 : 1
