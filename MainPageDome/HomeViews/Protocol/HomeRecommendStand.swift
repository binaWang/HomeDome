//
//  HomeRecommendStand.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/4.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit


protocol HomeRecommendStandData :HomeBaseCellData,HomeMoreViewData{
    var columnDatas:[HomeColumnData]{get}
}

protocol HomeRecommendStand:HomeBaseCellStands,HomeColumnVIewsProtocol ,HomeMoreViewProtocol {
    var inset:CGFloat {get}

}
extension HomeRecommendStand where Self : UITableViewCell{

}

