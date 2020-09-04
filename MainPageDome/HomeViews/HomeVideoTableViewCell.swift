//
//  HomeVideoTableViewCell.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/1.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class HomeVideoTableViewCell: UITableViewCell,HomeVideoCellStands {
    var indexPath: IndexPath?
    
    var delegate: HomeCellDelegate?

    var inset: CGFloat = 16
    
    private var videoImage:UIImageView = UIImageView()
    

    lazy var labelsView: HomeLabelsView =  HomeLabelsView()
    
    lazy var funcView: HomeFuncView = HomeFuncView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addViews()
        layoutViews()
        
    }
    func setData(_ data: HomeBaseCellData, index: IndexPath) {
        if let mode = data as? HomeVideoCellStandsData{
            labelsView.setDatas(data: mode)
            funcView.setData(data: mode)
        }
    }
    
    func addViews() {
        contentView.addSubview(labelsView)
        contentView.addSubview(videoImage)
        contentView.addSubview(funcView)
        videoImage.backgroundColor = UIColor.random
        videoImage.tag = HomeTableViewController.kPlayerViewTag
        videoImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(playClick))
        videoImage.addGestureRecognizer(tap)
    }
    @objc private func playClick(){
        if let index  = self.indexPath{
            self.delegate?.didSelectAction(action: .playVideo(index: index), object: nil)
        }
    }
    func layoutViews() {
        labelsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(inset)
        }
        videoImage.snp.makeConstraints { (make) in
            make.top.equalTo(labelsView.snp.bottom).offset(inset)
            make.leading.equalTo(labelsView.snp.leading)
            make.trailing.equalTo(labelsView.snp.trailing)
            make.height.equalTo(videoImage.snp.width).multipliedBy(193.0/343.0)
        }
        funcView.snp.makeConstraints { (make) in
            make.top.equalTo(videoImage.snp.bottom).offset(12)
            make.leading.equalTo(labelsView.snp.leading)
            make.trailing.equalTo(labelsView.snp.trailing)
            make.bottom.equalToSuperview().offset(-24).priorityLow()
        }

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
