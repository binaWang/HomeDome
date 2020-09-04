//
//  ConsultantView.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/3.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class ConsultantView: UIView {
        
    enum RatioType {
        case full
        case ratio(_  value:CGFloat)
    }
    var imageRatio : RatioType = .full
    private  var titleMargin : CGFloat = 12
    var titleRatio : RatioType = .full
    private  var imageView:UIImageView = UIImageView()
    private  var titleLabel:UILabel = UILabel()
    private  var shadow:Bool = true

    convenience init(imageRatio:RatioType ,titleRatio:RatioType , titleMargin:CGFloat = 12 ,shadow:Bool = false) {
        self.init(frame:CGRect.zero)
        self.imageRatio = imageRatio
        self.titleRatio = titleRatio
        self.shadow = shadow
        config()

    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        addSubview(imageView)
        addSubview(titleLabel)
        imageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            switch self.imageRatio{
            case .full:
                make.height.equalToSuperview()
            case .ratio(let ratio):
                make.height.equalTo(imageView.snp.width).multipliedBy(ratio)
            }
        }
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(titleMargin)
            switch self.titleRatio{
            case .full:
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            case .ratio(let ratio):
                make.height.equalTo(titleLabel.snp.width).multipliedBy(ratio)
                make.bottom.equalToSuperview()
            }

        }
        if shadow{
            self.shadowColor = MosCommonColor.invalid_or_auxiliary
            self.shadowOffset = CGSize(width: 2, height: 2)
            self.shadowOpacity = 0.23

        }
        imageView.backgroundColor = UIColor.random
    }
}

extension ConsultantView:HomeColumnSubView  {
    func setData(data: HomeColumnData?) {
        if let image = data?.imageString{
            self.imageView.image = UIImage(named: image)
        }else{
            self.imageView.image = nil
        }
        if let title = data?.titleString{
            self.titleLabel.text = title
        }else{
            self.titleLabel.text = nil
        }
    }
        
    
}

class ConsultantRatioView: ConsultantView {
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.imageRatio = .ratio(0.6)
        self.titleRatio = .ratio(0.34)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
