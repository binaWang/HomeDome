//
//  Colors.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/2.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

public struct MosCommonColor {
    /// 用于按钮, 图标, 文字 0xe0e0e0
    public static let app_Alert_Line = UIColor(hex: 0xe0e0e0)!
    /// 用于按钮, 图标, 文字 0x00B0F0
    public static let app_main_blue = UIColor(hex: 0x00B0F0)!
    /// 背景色, 分割线 0xF6F7F9
    public static let app_background = UIColor(hex: 0xF6F7F9)!
    /// 按钮, 通用绿色 0x1FC773
    public static let app_assist_green = UIColor(hex: 0x1FC773)!
    /// 按钮, icon 0xdf5757
    public static let app_assist_red = UIColor(hex: 0xdf5757)!
    /// 深黑色（导航栏标题颜色）0x333333
    public static let app_assist_dark_black = UIColor(hex: 0x333333)!
    /// 标题字体颜色 0x3C484D
    public static let app_assist_title = UIColor(hex: 0x3C484D)!
    /// 正文字体颜色 0x6A767D
    public static let app_assist_content_text = UIColor(hex: 0x6A767D)!
    /// 辅助字体颜色 0x96A3A8
    public static let app_assist_detail = UIColor(hex: 0x96A3A8)!
    
    /// 占位字体颜色
    public static let app_placeholder_gray = UIColor(hex: 0xC0CACE)!
    
    /// 辅助字体颜色 0xbbbbbb
    public static let app_assist_detail2 = UIColor(hex: 0xbbbbbb)!
    /// 淡辅助字体颜色 0xc7c7c7
    public static let app_assist_lightDetail = UIColor(hex: 0xc7c7c7)!
    
    /// 辅助提示浅红色字体 0xFE6C36
    public static let app_assist_light_red = UIColor(hex: 0xFE6C36)!
    
    /// 底部红色提示文字颜色
    public static let red_error_tips_color = UIColor(hex: 0xF34336)!
    
    /// 红色标签背景色
    public static let app_red_tips_background = UIColor(hex: 0xF9D5C7)!
    /// 红色标签文字颜色 FF534D
    public static let app_red_tips = UIColor(hex: 0xFF534D)!

    /// 底部刷新控件字体颜色 0x9c9c9c
    public static let refresh_footer_gray = UIColor(hex: 0x9c9c9c)!
    
    /// 导航栏的默认颜色 0xf9f9f9
    public static let nav_background = UIColor.white
    /// 蓝色 button的默认正常状态的颜色 0x00B0F0
    public static let button_blue_normal = MosCommonColor.app_main_blue

    /// 蓝色 button的默认选中状态的颜色 0xA5D6F5
    public static let button_blue_highlight =  UIColor(hex: 0xA5D6F5)!

    /// 红色 button 的默认正常状态的颜色 0xdf5757
    public static let button_red_normal = UIColor(hex: 0xdf5757)!
    /// 红色 button 的高亮颜色 0xe98989
    public static let button_red_highlight =  UIColor(hex: 0xe98989)!
    /// 失效/辅助文字的颜色 C2CACF
    public static let invalid_or_auxiliary = UIColor(hexString: "#C2CACF")!
    /// 按钮禁用状态下的文字颜色
    public static let button_text_color_disable = UIColor(hexString: "#647379")!
    /// button的警告正常状态的颜色 0xdf5757
    public static let button_warn_normal = UIColor(hex: 0xdf5757)!
    /// button的警告选中状态的颜色 0xe98989
    public static let button_warn_highlight = UIColor(hex: 0xe98989)!
    
    public static let deep_Blue = UIColor(hexString: "#001E50")
    
    /// 全局通用的绿色 #00B0F0
    public static let universal_green = UIColor(hexString: "#00B0F0")
    
    public static let light_Blue = UIColor(hexString: "#001E50", transparency: 0.75)
    
    public static func deep_Blue(_ transparency: CGFloat = 1.0) -> UIColor? {
        return UIColor(hexString: "#001E50", transparency: transparency)
    }
    
    /// 浅红背景色 d5f2df
    public static let bg_color_light_red = UIColor(hex: 0xf9dddd)!
    
    /// 红色文字 def8fd
    public static let text_color_red = UIColor(hex: 0xdf5757)!
    
    /// 浅黄背景色 ffe0c7
    public static let bg_color_light_yellow = UIColor(hex: 0xffe0c7)!
    
    /// 黄色文字 ff9947
    public static let text_color_yellow = UIColor(hex: 0xff9947)!
    
    /// 浅绿背景色 d5f2df
    public static let bg_color_light_green = UIColor(hex: 0xd5f2df)!
    
    /// 浅蓝背景色 def8fd
    public static let bg_color_light_blue = UIColor(hex: 0xdef8fd)!
    
    /// 绿色文字 2ebf60
    public static let text_color_green = UIColor(hex: 0x2ebf60)!
    
    /// 线条颜色 0xDFE4E8
    public static let line_color = UIColor(hex: 0xDFE4E8)!
    
    /// 个人信息颜色 0xfefefe
    public static let info_color = UIColor(hex: 0xfefefe)!
    
    ///汽车流量里面wifi流量颜色 0x5aa7f5
    public static let wifi_color = UIColor(hex: 0x5aa7f5)!
    
    ///汽车流量里面在线媒体颜色 0x39c0ff
    public static let online_color = UIColor(hex: 0x39c0ff)!
    
    ///绑定车辆状态识别码颜色 0x5b89f5
    public static let bindingStatusCode_color = UIColor(hex: 0x5b89f5)!
    
    ///水印颜色 0xAD5A34
    public static let watermark_color = UIColor(hex: 0xAD5A34)!
    
    ///进围栏提醒 0xfd9848
    public static let enterGeofenc_color = UIColor(hex: 0xfd9848)!
    
    ///进围栏提醒 0x306aea
    public static let addressBookHighlights_color = UIColor(hex: 0x306aea)!
    
    //车辆位置 0x658fee
    public static let carlocation_color = UIColor(hexString: "#001E50")!
    
    //品牌也cell之间间隔的色值 0xF7F7F7
    public static let brandGrey_color = UIColor(hex: 0xF7F7F7)!
    
    //品牌也cell活动已结束字色 0xc8c9cd
    public static let brandActivityFinishButton_color = UIColor(hex: 0xc8c9cd)!
    
    //品牌也cell活动立即报名字色 0x457bea
    public static let brandActivityNowButton_color = UIColor(hex: 0x457bea)!
    //调整授权cell背景色0xfafcff
    public static let accreditCell_color = UIColor(hex: 0xfafcff)!
    
    //着重强调信息
    public static let text_marked_color = UIColor(hex: 0x2a2a2a)!
    
    //普通提示信息
    public static let text_commom_color = UIColor(hex: 0x727272)!

    /// 4784FF
    public static let bg_color_4784FF = UIColor(hex: 0x4784FF)!
    /// E3E3E3
    public static let bg_color_E3E3E3 = UIColor(hex: 0xE3E3E3)!
    
    /// 品牌首页占位
    public static let brand_default = UIColor(hex: 0xEFF1F4)!

    
}
