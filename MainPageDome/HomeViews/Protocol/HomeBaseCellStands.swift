//
//  HomeBaseCellStands.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/28.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
/// HomeCell点击事件
enum HomeCellActions {
    // 列的cell
    case columnItem(index:IndexPath?,itemIndex:Int,data:HomeColumnData)
    /// 报名
    case signUp(index:IndexPath?)
    /// 更多
    case moreInfo(index:IndexPath?)
    /// 关注
    case follow(index:IndexPath?)
    /// 播放视频
    case playVideo(index:IndexPath?)
    /// 点击标签
    case textTagTap(index:IndexPath?,tag:String)
    /// 下边三个关注等按钮
    case funcAcitom(index:IndexPath?,type:HomeFuncView.TapType)

}

protocol HomeBaseCellData {
    func cellType()->HomeBaseCellStands.Type
}

protocol HomeBaseCellStands:UITableViewCell {
    var delegate : HomeCellDelegate?{get set}
    var indexPath:IndexPath?{get}
    func setData(_ data: HomeBaseCellData,index:IndexPath)
    func addViews()
    func layoutViews()
}

protocol HomeBaseCellActions: NSObjectProtocol {
    
}
protocol HomeTotalCellData:HomeImageCellStandsData,HomeVideoCellStandsData {
    
}
protocol HomeCellDelegate : NSObjectProtocol {
    func didSelectAction(action:HomeCellActions,object:Any?)
}

extension HomeTotalCellData{

    func cellType()->HomeBaseCellStands.Type{
        if self.videoURL != ""{
            return HomeVideoTableViewCell.self
        }
        switch self.columnDatas.count {
        case 1:
            return HomeSingleColumnViewCell.self
        case 2,4:
            return HomeDoubleColumnImageCell.self
        default:
            return HomeThreeColumnImageCell.self
        }
    }
}
