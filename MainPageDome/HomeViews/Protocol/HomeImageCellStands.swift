//
//  HomeImageCellStands.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/25.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
protocol HomeImageCellStandsData :HomeBaseCellData,HomeLabelsViewDatas,HomeFuncViewData{
    var columnDatas:[HomeColumnData]{get}
}

protocol HomeImageCellStands:HomeBaseCellStands,HomeLabelsViewProtocol ,HomeFuncViewProtocol ,HomeColumnVIewsProtocol,HomeLabelsViewDelegate,HomeColumnVIewsActionDelegate,HomeFuncViewDelegate{
    var inset:CGFloat {get}
}

extension HomeImageCellStands where Self : UITableViewCell{

}

