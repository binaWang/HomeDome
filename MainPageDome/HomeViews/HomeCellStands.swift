//
//  HomeTableViewCell.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/25.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
protocol HomeCellStandsData :HomeBaseCellData,HomeLabelsViewDatas,HomeFuncViewData{
    var imageDatas:[HomeImageData]{get}
}
extension HomeCellStandsData{

    func cellType()->HomeBaseCellStands.Type{
        switch self.imageDatas.count {
        case 1:
            return HomeTableViewCell.self
        case 2,4:
            return HomeDoubleColumnImageCell.self
        default:
            return HomeThreeColumnImageCell.self
        }
    }
}
protocol HomeCellStands:HomeBaseCellStands,HomeLabelsViewProtocol ,HomeFuncViewProtocol ,HomeImageVIewsProtocol{

}

extension HomeCellStands where Self : UITableViewCell{
    func setData(_ data: HomeBaseCellData) {
        if let model =  data as? HomeCellStandsData{
            labelsView.setDatas(data: model)
            imageViews.setData(data: model.imageDatas)
            funcView.setData(data: model)
        }
    }

    func addViews(){
        contentView.addSubview(labelsView)
        contentView.addSubview(imageViews)
        contentView.addSubview(funcView)
    }
    func layoutViews(){
        labelsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        imageViews.snp.makeConstraints { (make) in
            make.top.equalTo(labelsView.snp.bottom).offset(10)
            make.leading.equalTo(labelsView.snp.leading)
            make.trailing.equalTo(labelsView.snp.trailing)
        }
        funcView.snp.makeConstraints { (make) in
            make.top.equalTo(imageViews.snp.bottom).offset(10)
            make.leading.equalTo(labelsView.snp.leading)
            make.trailing.equalTo(labelsView.snp.trailing)
            make.bottom.equalToSuperview().inset(10).priorityLow()
        }

    }

}

