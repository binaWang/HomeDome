//
//  HomeSingleColumnViewCell.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/31.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class HomeSingleColumnViewCell: HomeBaseCell ,HomeImageCellStands{
    
    var inset: CGFloat = 16
    
    var column:HomeColumnVIews.Column {
        get{
            return .single
        }
    }
    var scale:CGFloat {
        get{
            return 193.0/343.0
        }
    }
    

    lazy var columnView: HomeColumnVIews = HomeColumnVIews(maxWidth: kScreenWith  -  inset * 2, colum: column, itemType: ConsultantView.self ,scale:scale)
    
    lazy var labelsView: HomeLabelsView =  HomeLabelsView()
    
    lazy var funcView: HomeFuncView = HomeFuncView()
    

    override func setData(_ data: HomeBaseCellData, index: IndexPath) {
        super.setData(data, index: index)

        if let model =  data as? HomeImageCellStandsData{
            labelsView.setDatas(data: model)
            columnView.setData(data: model.columnDatas)
            funcView.setData(data: model)
        }
    }

    override func addViews(){
        contentView.addSubview(labelsView)
        contentView.addSubview(columnView)
        contentView.addSubview(funcView)
        labelsView.delegate = self
        columnView.delegate = self
        funcView.delegate = self
    }
    override func layoutViews(){
        labelsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(inset)
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
class  HomeDoubleColumnImageCell: HomeSingleColumnViewCell {
    override var column:HomeColumnVIews.Column {
            return .double
    }

    override var scale:CGFloat {
        return 1
    }

}

class  HomeThreeColumnImageCell: HomeSingleColumnViewCell {
    override var column:HomeColumnVIews.Column {
            return .three
    }
    override var scale:CGFloat {
        return 1
    }

}

