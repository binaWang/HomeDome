//
//  HomeNewImageViews.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/31.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
protocol ImageStackViewProtocol : UITableViewCell {
    var imageViews: ImageStackView{get}

}

class ImageStackView: UIView {
    var imageViews:[UIImageView] = []
    private var stackViews: [UIStackView] = []
    /// stackView 最大子控件数
    private var stackMaxSub : UInt = 3
    /// stackViews 最大数量
    private let stackMaxNumber : UInt = 3

    convenience init(maxSub:UInt) {
        self.init()
        self.configUI()
        self.stackMaxSub = maxSub
    }
    
    

    private func layoutButtons(dataSource: [HomeImageData]){
        let numbers = Int(ceil(Float(dataSource.count)/Float(stackMaxSub)))
        var top = self.snp.top

        for (index,item) in imageViews.enumerated(){
            if index >=  dataSource.count{
                item.image = nil
            }else{
                item.image = UIImage(named: dataSource[index].image ?? "")
            }
        }
        for (index,stack) in stackViews.enumerated(){

            stack.snp.remakeConstraints { (make) in
                make.left.equalTo(self.snp.left).offset(0)
                make.right.equalTo(self.snp.right).offset(0)
                if index < numbers && index < stackMaxNumber{
                    make.top.equalTo(top).offset(0)
                    make.height.equalTo(75)
                    stack.isHidden = false
                }else{
                    make.top.equalTo(top).offset(0)
                    make.height.equalTo(0)
                    stack.isHidden = true
                }
                if stack == stackViews.last{
                    make.bottom.equalTo(self.snp.bottom).offset(0)
                }
            }
            top = stack.snp.bottom
        }
        self.updateConstraintsIfNeeded()
    }
    private func configUI()
    {

        for i in 0..<stackMaxNumber{
            let stack = UIStackView()
            stack.alignment = .fill
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.tag = Int(i)
            for _ in 0..<stackMaxSub {
                let item = UIImageView()
                stack.addArrangedSubview(item)
                imageViews.append(item)
            }
            stackViews.append(stack)
        }
        self.addSubviews(stackViews)
    }

}
