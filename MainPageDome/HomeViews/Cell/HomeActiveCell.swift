//
//  HomeActiveCell.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/4.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class HomeActiveCell: HomeBaseCell,HomeActiveViewProtocol {
    var inset: CGFloat = 16
    private var activeImageView:UIImageView = UIImageView()


    var activeView: HomeActiveView = HomeActiveView()
    
    override func layoutViews() {
        activeImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(inset)
            make.height.equalTo(activeImageView.snp.width).multipliedBy(193.0/343.0)

        }

        activeView.snp.makeConstraints { (make) in
            make.top.equalTo(activeImageView.snp.bottom).offset(20)
            make.leading.equalTo(activeImageView.snp.leading)
            make.trailing.equalTo(activeImageView.snp.trailing)
            make.bottom.equalToSuperview().offset(-24)
        }
    
    }
    override func setData(_ data: HomeBaseCellData, index: IndexPath) {
        if let model = data as? HomeActiveViewData{
            activeView.setData(data: model)
            activeImageView.image = UIImage(named: model.activeImage ?? "")
        }
    }
    override func addViews() {
        contentView.addSubview(activeImageView)
        activeImageView.backgroundColor = UIColor.random
        contentView.addSubview(activeView)
    }


}
