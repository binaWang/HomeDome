//
//  HomeVideoTableViewCell.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/1.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class HomeVideoTableViewCell: UITableViewCell,HomeVideoCellStands {
    var delegate: TableViewPlayerCellDelegate?
    

    
    
    var inset: CGFloat = 30
    
    private var videoImage:UIImageView = UIImageView()
    

    lazy var labelsView: HomeLabelsView =  HomeLabelsView()
    
    lazy var funcView: HomeFuncView = HomeFuncView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addViews()
        layoutViews()
        
    }
    func setData(_ data: HomeBaseCellData) {
        if let mode = data as? HomeVideoCellStandsData{
            labelsView.setDatas(data: mode)
            funcView.setData(data: mode)
        }
    }
    
    func addViews() {
        contentView.addSubview(labelsView)
        contentView.addSubview(videoImage)
        contentView.addSubview(funcView)
    }
    
    func layoutViews() {
        labelsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(0)
            make.leading.trailing.equalToSuperview().inset(inset)
        }
        videoImage.snp.makeConstraints { (make) in
            make.top.equalTo(labelsView.snp.bottom).offset(inset)
            make.leading.equalTo(labelsView.snp.leading)
            make.trailing.equalTo(labelsView.snp.trailing)
            make.height.equalTo(videoImage.snp.width).multipliedBy(0.45)
        }
        funcView.snp.makeConstraints { (make) in
            make.top.equalTo(videoImage.snp.bottom).offset(10)
            make.leading.equalTo(labelsView.snp.leading)
            make.trailing.equalTo(labelsView.snp.trailing)
            make.bottom.equalToSuperview().inset(10).priorityLow()
        }

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
