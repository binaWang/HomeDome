//
//  HomeRecommendCell.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/4.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
/// 精彩推荐
class HomeRecommendCell: HomeBaseCell ,HomeRecommendStand{
    
    var inset: CGFloat = 16
    
    
    lazy var columnView: HomeColumnVIews = HomeColumnVIews(maxWidth: kScreenWith - inset * 2, colum: .double, itemType: ConsultantRatioView.self)
    
    lazy var moreViews: HomeMoreView = HomeMoreView()
    
    override func addViews() {
        contentView.addSubview(moreViews)
        contentView.addSubview(columnView)
    }
    override func layoutViews() {
        moreViews.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(inset)
        }
        columnView.snp.makeConstraints { (make) in
            make.top.equalTo(moreViews.snp.bottom).offset(20)
            make.leading.equalTo(moreViews.snp.leading)
            make.trailing.equalTo(moreViews.snp.trailing)
            make.bottom.equalToSuperview().offset(-24).priorityLow()
        }

    }
    override func setData(_ data: HomeBaseCellData, index: IndexPath) {
        super.setData(data, index: index)
        if let model = data as? HomeRecommendStandData{
            moreViews.setData(data: model)
            columnView.setData(data:model.columnDatas)
        }
        
    }

}
