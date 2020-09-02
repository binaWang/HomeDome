//
//  HomeImageCellStands.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/25.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
protocol HomeImageCellStandsData :HomeBaseCellData,HomeLabelsViewDatas,HomeFuncViewData{
    var imageDatas:[HomeImageData]{get}
}

protocol HomeImageCellStands:HomeBaseCellStands,HomeLabelsViewProtocol ,HomeFuncViewProtocol ,HomeImageVIewsProtocol,HomeLabelsViewDelegate,HomeImageVIewsActionDelegate,HomeFuncViewDelegate{
    var inset:CGFloat {get}
}

extension HomeImageCellStands where Self : UITableViewCell{
    func setData(_ data: HomeBaseCellData, index: IndexPath) {
        if let model =  data as? HomeImageCellStandsData{
            labelsView.setDatas(data: model)
            imageViews.setData(data: model.imageDatas)
            funcView.setData(data: model)
        }
    }

    func addViews(){
        contentView.addSubview(labelsView)
        contentView.addSubview(imageViews)
        contentView.addSubview(funcView)
        labelsView.delegate = self 
        imageViews.delegate = self
        funcView.delegate = self
    }
    func layoutViews(){
        labelsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(inset)
        }
        imageViews.snp.makeConstraints { (make) in
            make.top.equalTo(labelsView.snp.bottom).offset(12)
            make.leading.equalTo(labelsView.snp.leading)
            make.trailing.equalTo(labelsView.snp.trailing)
        }
        funcView.snp.makeConstraints { (make) in
            make.top.equalTo(imageViews.snp.bottom).offset(14)
            make.leading.equalTo(labelsView.snp.leading)
            make.trailing.equalTo(labelsView.snp.trailing)
            make.bottom.equalToSuperview().offset(-24).priorityLow()
        }

    }

}

