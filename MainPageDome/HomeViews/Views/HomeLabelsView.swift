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

protocol HomeLabelsViewDelegate: NSObjectProtocol {
    func didTapLabel(text:String)
}

extension HomeLabelsViewDelegate   where Self :HomeImageCellStands{
    func didTapLabel(text:String){
    }
}


class HomeLabelsView: UIView {
    
    weak var delegate : HomeLabelsViewDelegate?

   private lazy  var titleLabel : ActiveLabel = ActiveLabel().then{
        $0.textColor = MosCommonColor.app_assist_dark_black
        $0.font = UIFont.vwText_Regular(ofSize: 18)
        $0.numberOfLines = 2
    }
    private lazy var contentLabel : ActiveLabel = ActiveLabel().then{
        $0.textColor = MosCommonColor.app_assist_content_text
        $0.font = UIFont.svwPingFangSC_Medium(ofSize:14)
        
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDatas( data:HomeLabelsViewDatas){
        let pattern = "#点位"
        let customType = ActiveType.custom(pattern: pattern)
        titleLabel.enabledTypes = [customType]
        titleLabel.text = pattern +  (data.titleText ?? "")
        titleLabel.customColor[customType] =  MosCommonColor.app_main_blue
        titleLabel.handleCustomTap(for: customType) {[weak self] (str) in
            self?.delegate?.didTapLabel(text: str)
        }

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
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(0)
        }

    }
}
