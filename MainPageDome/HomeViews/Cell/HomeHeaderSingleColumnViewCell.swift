//
//  HomeHeaderSingleColumnViewCell.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/4.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
protocol HomeUserImageCellStandData:HomeImageCellStandsData,HomeHeadrViewDatas {
    
}

class HomeUserSingleColumnViewCell: HomeSingleColumnViewCell ,HomeHeadrViewProtocol{
    var usersInfo: HomeHeadrView =  HomeHeadrView()
        
    override func setData(_ data: HomeBaseCellData, index: IndexPath) {
        super.setData(data, index: index)

        if let model =  data as? HomeHeadrViewDatas{
            usersInfo.setData(data: model)
        }
    }

    override func addViews(){
        contentView.addSubview(usersInfo)

        contentView.addSubview(labelsView)
        contentView.addSubview(columnView)
        contentView.addSubview(funcView)
        labelsView.delegate = self
        columnView.delegate = self
        funcView.delegate = self
    }
    override func layoutViews(){
        usersInfo.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(inset)

        }
        
        labelsView.snp.makeConstraints { (make) in
            make.top.equalTo(usersInfo.snp.bottom).offset(16)
            make.leading.equalTo(usersInfo.snp.leading)
            make.trailing.equalTo(usersInfo.snp.trailing)
        }
        columnView.snp.makeConstraints { (make) in
            make.top.equalTo(labelsView.snp.bottom).offset(12)
            make.leading.equalTo(labelsView.snp.leading)
            make.trailing.equalTo(labelsView.snp.trailing)
        }
        funcView.snp.makeConstraints { (make) in
            make.top.equalTo(columnView.snp.bottom).offset(14)
            make.leading.equalTo(labelsView.snp.leading)
            make.trailing.equalTo(labelsView.snp.trailing)
            make.bottom.equalToSuperview().offset(-24).priorityLow()
        }

    }


}
class  HomeUserDoubleColumnImageCell: HomeUserSingleColumnViewCell {
    override var column:HomeColumnVIews.Column {
            return .double
    }

    override var scale:CGFloat {
        return 1
    }

}

class  HomeUserThreeColumnImageCell: HomeUserSingleColumnViewCell {
    override var column:HomeColumnVIews.Column {
            return .three
    }
    override var scale:CGFloat {
        return 1
    }

}

