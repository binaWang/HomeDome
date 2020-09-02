//
//  CustomItemView.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/21.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class PageMenuItemView: UIView,PageMenuItem {
    func itemWith() -> MenuConfigModel.ItemWidthType {
        if imageView.image == nil {
            return .autoText
        }
        return .width(50)
    }
    
    var titleLabel : UILabel = UILabel().then{
        $0.textColor = MosCommonColor.app_assist_content_text
        $0.font = UIFont.svwPingFangSC_Medium(ofSize:16)
    }
    var imageView : UIImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-14)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(title: String?, image: UIImage?) {
        titleLabel.text = title
        imageView.image = image

        if image != nil{
            titleLabel.isHidden = true
        }
    }
    
    func normalState() {
        titleLabel.textColor = MosCommonColor.app_assist_content_text
    }
    
    func didSelectedState() {
        titleLabel.textColor = MosCommonColor.app_assist_dark_black

    }
    
    
    


}
