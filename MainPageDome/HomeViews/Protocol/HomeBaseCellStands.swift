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
    var indexPath:IndexPath?{get set}
    func setData(_ data: HomeBaseCellData,index:IndexPath)
    func addViews()
    func layoutViews()
}

extension HomeBaseCellStands where Self : UITableViewCell{

}
protocol HomeBaseCellActions: NSObjectProtocol {
    
}
protocol HomeTotalCellData:HomeImageCellStandsData,HomeVideoCellStandsData,HomeActiveViewData,HomeRecommendStandData ,HomeADCellData,HomeHeadrViewDatas{
    var customType:Int {get}
}
protocol HomeCellDelegate : NSObjectProtocol {
    func didSelectAction(action:HomeCellActions,object:Any?)
}

extension HomeTotalCellData{

    func cellType()->HomeBaseCellStands.Type{

        switch self.customType {
        case 0:
            return HomeVideoTableViewCell.self
        case 1:
            let head = Int.random(in: 0...10) > 5
                switch self.columnDatas.count {
                case 1:
                    if head{
                        return HomeSingleColumnViewCell.self

                    }else{
                        return HomeUserSingleColumnViewCell.self
                    }
                case 2,4:
                    if head{
                        return HomeDoubleColumnImageCell.self

                    }else{
                        return HomeUserDoubleColumnImageCell.self
                    }

                default:
                    if head{
                        return HomeThreeColumnImageCell.self

                    }else{
                        return HomeUserThreeColumnImageCell.self
                    }

                }
        case 2:
            return HomeADCell.self

        case 3:

            return HomeRecommendCell.self
        case 4:
            return HomeActiveCell.self

        default:
            return HomeVideoTableViewCell.self

        }
    }

}
