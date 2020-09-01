//
//  SVWImageViews.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/31.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class SVWImageViews: UIView {
    weak var delegate : HomeImageVIewsActionDelegate?

    private var layout : LayoutManager = LayoutManager()
    private var horuzontalMaxcount : HorizontalCount = .one
    private var verticalStackView:UIStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    
    /// 固定三个
    private lazy var horuzontalStackView:[UIStackView] = []
    
    /// 固定九个
    private lazy var imageViews:[UIImageView] = []

    override init(frame: CGRect) {
        super.init(frame:frame)
        config()
        configImageView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    convenience init(maxWidth:CGFloat,horuzontal:HorizontalCount) {
//        self.init()
//    }
    func configImageView(){
        for _ in 0...9 {
            let imageView = UIImageView()
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleToFill
            imageViews.append(imageView)
        }
    }
    func config(){
        verticalStackView.spacing = layout.spacing
        
        addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(verticalStackView.snp.width).multipliedBy(1)
            make.bottom.equalToSuperview()
        }
        for _ in 0...3 {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = layout.spacing
            
            horuzontalStackView.append(stack)
        }
        
    }
    func setData(data:[HomeImageData]){
        
        for stack in horuzontalStackView {
            stack.removeArrangedSubviews()
        }
        verticalStackView.removeArrangedSubviews()
        
        var horuzontalMaxCount: Int = 1
        var verticalMaxCount : Int = 1
        switch data.count {
        case 0,1:
            horuzontalMaxCount = 1
            verticalMaxCount = 1
        case 2:
            horuzontalMaxCount = 2
            verticalMaxCount = 1
        case 3:
            horuzontalMaxCount = 3
            verticalMaxCount = 1
        case 4:
            horuzontalMaxCount = 2
            verticalMaxCount = 2

        case 5,6:
            horuzontalMaxCount = 3
            verticalMaxCount = 2
        case 7,8,9:
            horuzontalMaxCount = 3
            verticalMaxCount = 3
        default:
            horuzontalMaxCount = 3
            verticalMaxCount = 3
        }
                
        var horuzontalNumber: Int = 0
        var verticalNumber : Int = 0

        for (index,imageView) in imageViews.enumerated() {
            if horuzontalNumber < horuzontalMaxCount &&  verticalNumber < verticalMaxCount{
                if index < data.count{
                    imageView.image = UIImage(named: data[index].image ?? "")

                    horuzontalStackView[verticalNumber].addArrangedSubview(imageView)
                }else{
                    imageView.image = nil
                }
                horuzontalStackView[verticalNumber].addArrangedSubview(imageView)

                horuzontalNumber += 1
            }else if verticalNumber < verticalMaxCount{
                
                verticalStackView.addArrangedSubview(horuzontalStackView[verticalNumber])
                horuzontalNumber = 0
                verticalNumber += 1
            }
        }

        
    }
}
extension SVWImageViews{
    enum HorizontalCount {
        case one
        case two
        case three
    }
    struct LayoutManager {
        
        var spacing : CGFloat = 4

        var maxWidth : CGFloat = 0
    }
}
