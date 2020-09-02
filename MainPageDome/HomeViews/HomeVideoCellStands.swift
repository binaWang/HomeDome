//
//  HomeVideoCellStands.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/1.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
protocol HomeVideoCellStandsData :HomeBaseCellData,HomeLabelsViewDatas,HomeFuncViewData{

    var videoImageStr:String{get}
    var videoURL:String{get}
}

protocol HomeVideoCellStands:HomeBaseCellStands,HomeLabelsViewProtocol ,HomeFuncViewProtocol {
    var inset:CGFloat {get}
}
extension HomeVideoCellStands where Self : UITableViewCell{


}

