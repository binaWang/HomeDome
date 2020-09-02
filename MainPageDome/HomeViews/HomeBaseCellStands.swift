//
//  HomeBaseCellStands.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/28.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit


protocol HomeBaseCellData {
    func cellType()->HomeBaseCellStands.Type
}

protocol HomeBaseCellStands:UITableViewCell {
    var delegate : HomeTotalCellDelegate?{get set}
    func setData(_ data: HomeBaseCellData,index:IndexPath)
    func addViews()
    func layoutViews()
}
protocol HomeBaseCellActions: NSObjectProtocol {
    
}
protocol HomeTotalCellData:HomeImageCellStandsData,HomeVideoCellStandsData {
    
}
protocol HomeTotalCellDelegate : NSObjectProtocol {
    func didTapTagLabel(text:String)
    func didTapImageView(index:Int,model:HomeImageData)
    func didTapFuncView(type:HomeFuncView.TapType)
    func playVideoAt(index:IndexPath )
}
extension HomeTotalCellData{

    func cellType()->HomeBaseCellStands.Type{
        if self.videoURL != ""{
            return HomeVideoTableViewCell.self
        }
        switch self.imageDatas.count {
        case 1:
            return HomeSingleColumnViewCell.self
        case 2,4:
            return HomeDoubleColumnImageCell.self
        default:
            return HomeThreeColumnImageCell.self
        }
    }
}
