//
//  HomeActiveView.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/4.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
protocol HomeActiveViewData {
    var activeTitleString:String? { get  }
    var timeString:String? { get  }
    var addressString:String? { get  }
    var stateType:String? { get  }
    var activeImage:String? {get}
}
protocol HomeActiveViewProtocol : UITableViewCell {
    var activeView:HomeActiveView{get set}
}

class HomeActiveView: UIView {
    private var titleLable:UILabel = UILabel().then{
        $0.textColor = MosCommonColor.app_assist_dark_black
        $0.font = UIFont.svwPingFangSC_Medium(ofSize: 16)
        $0.numberOfLines = 2
    }
    
    private var timeLabel:UILabel = UILabel().then{
        $0.textColor = MosCommonColor.app_assist_detail
        $0.font = UIFont.svwPingFangSC_Medium(ofSize: 12)
    }
    private var addressLabel:UILabel = UILabel().then{
        $0.textColor = MosCommonColor.app_assist_detail
        $0.font = UIFont.svwPingFangSC_Medium(ofSize: 12)
    }

    private var sigupButton: UIButton = UIButton().then{
        $0.setTitle("活动已结束", for: .disabled)
        $0.setTitleColor(MosCommonColor.app_assist_detail, for: .disabled)
        $0.setBackgroundImage(nil, for: .disabled)
        
        $0.setTitle("立即报名", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.setBackgroundImage(nil, for: .normal)

        $0.setTitle("预热中", for: .selected)
        $0.setTitleColor(MosCommonColor.universal_green, for: .selected)
        $0.setBackgroundImage(nil, for: .selected)

        $0.titleLabel?.font = UIFont.svwPingFangSC_Medium(ofSize: 12)
        
        $0.setImage(nil, for: .normal)
    }


    func setData(data:HomeActiveViewData){
        self.titleLable.text = data.activeTitleString
        self.timeLabel.text = data.timeString
        self.addressLabel.text = data.addressString
        
        ///TODO: state

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        sigupButton
    }
    private func config(){
        addSubview(titleLable)
        addSubview(timeLabel)
        addSubview(addressLabel)
        addSubview(sigupButton)
        sigupButton.backgroundColor = UIColor.random
        titleLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.right.equalToSuperview()
        }
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLable.snp.bottom).offset(12)
            make.leading.equalTo(titleLable.snp.leading).offset(0)
            make.trailing.lessThanOrEqualTo(sigupButton.snp.leading).offset(-12)
        }
        addressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.bottom).offset(4)
            make.leading.equalTo(timeLabel.snp.leading).offset(0)
            make.trailing.lessThanOrEqualTo(sigupButton.snp.leading).offset(-12)
        }
        
        sigupButton.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.top).offset(0)
//            make.bottom.equalTo(addressLabel.snp.bottom).offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.size.equalTo(CGSize(width: 72, height: 28))
            make.bottom.equalToSuperview().offset(-16)
        }

    }
}
