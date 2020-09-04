//
//  HomeADCell.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/4.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

protocol HomeADCellData {
    var columnDatas:[HomeColumnData]{get}

}

class HomeADCell: HomeBaseCell,HomeColumnVIewsProtocol {
    var inset:CGFloat = 16
    lazy var columnView: HomeColumnVIews =  HomeColumnVIews(maxWidth: kScreenWith - inset * 2, colum: .three, itemType: ConsultantView.self, scale: 1.58)
    
    override func addViews() {
        contentView.addSubview(columnView)
    }

    override func setData(_ data: HomeBaseCellData, index: IndexPath) {
        super.setData(data, index: index)
        if let model = data as? HomeADCellData{
            columnView.setData(data: model.columnDatas)
        }
    }
    override func layoutViews() {
        columnView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(24)
            make.bottom.equalTo(contentView.snp.bottom).offset(-24)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }

    }

}
