//
//  HomeMoreView.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/4.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

protocol HomeMoreViewData {
    var moreTitle:String? { get  }
    var showMoreButton:Bool? { get  }

}
protocol HomeMoreViewProtocol : UITableViewCell {
    var moreViews:HomeMoreView{get set}
}

class HomeMoreView: UIView {
    private var titleLable:UILabel = UILabel().then{
        $0.textColor = UIColor.init(hexString: "#373737")
        $0.font = UIFont.svwPingFangSC_Medium(ofSize: 16)
    }
    private var moreButton: UIButton = UIButton().then{
        $0.setTitle("更多", for: .normal)
        $0.setTitleColor(MosCommonColor.app_assist_detail, for: .normal)
        $0.titleLabel?.font = UIFont.svwPingFangSC_Medium(ofSize: 12)
        
        $0.setImage(nil, for: .normal)
    }
    func setData(data:HomeMoreViewData ){
        self.titleLable.text  = data.moreTitle
        self.moreButton.isHidden = data.showMoreButton == true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config(){
        addSubview(titleLable)
        addSubview(moreButton)
        titleLable.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.lessThanOrEqualTo(moreButton.snp.leading).offset(-10)
            make.height.equalTo(20)
        }
        moreButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
