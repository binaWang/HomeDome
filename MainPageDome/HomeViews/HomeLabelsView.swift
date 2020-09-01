//
//  HomeLabelsView.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/25.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
import Then
import SnapKit
protocol HomeLabelsViewDatas {
    var titleText:String?{get}
    var contentText:String?{get}
}

protocol HomeLabelsViewProtocol: UITableViewCell {
    var labelsView: HomeLabelsView {get set}
//    func addlabelsView(top:SnapKit.ConstraintItem,offset:CGFloat)-> SnapKit.ConstraintItem
}
extension HomeLabelsViewProtocol where Self : UITableViewCell{
//    func addlabelsView(top:SnapKit.ConstraintItem,offset:CGFloat)-> SnapKit.ConstraintItem{
//        l
//    }

}



class HomeLabelsView: UIView {
    lazy private var titleLabel : UILabel = UILabel().then{
        $0.textColor = UIColor.random()
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    lazy private var contentLabel : UILabel = UILabel().then{
        $0.textColor = UIColor.random()
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDatas( data:HomeLabelsViewDatas){
        titleLabel.text = data.titleText
        contentLabel.text = data.contentText
    }
    private func configLabels(){
        addSubview(titleLabel)
        addSubview(contentLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.top.equalToSuperview()
        }
        contentLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(0)
        }

    }
}
