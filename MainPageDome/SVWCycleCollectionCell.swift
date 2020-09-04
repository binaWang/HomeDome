//
//  CustomCollectionCell.swift
//  CustomCycleScrollView
//
//  Created by 王斌 on 2020/6/7.
//  Copyright © 2020 SVW. All rights reserved.
//

import UIKit
import SnapKit

import Kingfisher
class SVWCycleCollectionCell: UICollectionViewCell {
    private var imageView:UIImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.backgroundColor = UIColor(hexString: "#D6D6D6")
        $0.layer.masksToBounds = true
    }
    
    func setData(image:String){
        imageView.kf.setImage(with: URL.init(string: image))
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        updateSubConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(INIT_CODER_NIL_WARRNING)
    }
    func updateSubConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
}
