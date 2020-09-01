//
//  HomeImageVIews.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/25.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
import SnapKit
protocol HomeImageData {
    var image:String? {get}
}
protocol HomeImageVIewsProtocol : UITableViewCell {
    var imageViews: HomeImageVIews{get}
//    func addHomeImageVIewsView(top:SnapKit.ConstraintItem,offset:CGFloat)-> SnapKit.ConstraintItem

}

extension HomeImageVIewsProtocol where Self : UITableViewCell{
//    func addHomeImageVIewsView(top:SnapKit.ConstraintItem,offset:CGFloat)-> SnapKit.ConstraintItem{
//        contentView.addSubview(imageViews)
//        imageViews.snp.makeConstraints { (make) in
//            make.leading.equalToSuperview().offset(0)
//            make.trailing.equalToSuperview().offset(0)
//            make.top.equalTo(top).offset(offset)
//            make.bottom.equalToSuperview().offset(0)
//        }
//        return imageViews.snp.bottom
//    }

}

protocol HomeImageVIewsActionDelegate:NSObjectProtocol  {
    func didTapImages(index: Int, model:HomeImageData)
}

class HomeImageVIews: UIView {


    weak var delegate : HomeImageVIewsActionDelegate?
    private  var layout :LayoutManager = LayoutManager(column: .single, maxWidth: 0)
    private static let verticalMax:Int = 3
    private var images : [String] = []
    private var imageViews : [UIImageView] = []
    private var horizontalCount: Int = 1
    private var dataSource: [HomeImageData] = []
    private var stackHorizontalViews: [UIStackView] = []
    convenience init(maxWidth:CGFloat ,colum:  Column) {
        self.init()

        layout = LayoutManager(column: colum, maxWidth: maxWidth)


        configStackViews()
    }
    
    func setData(data:[HomeImageData]){

        for (index,imageView) in imageViews.enumerated() {
            if index < data.count ,
                index >= 0 ,
                let imageStr = data[index].image{
                imageView.image = UIImage(named:imageStr)
            }else{
                imageView.image = nil
            }
        }
        dataSource = data

        let row = layout.numberOfRow(count: data.count)
        let height = layout.stackHeight()
        var top = self.snp.top

        for  (index,stack) in stackHorizontalViews.enumerated(){
            stack.snp.updateConstraints { (make) in
                if index < row{
                    if index != 0{
                        make.top.equalTo(top).offset(layout.imageMargin)
                    }
                    make.height.equalTo(height)
                }else{
                    make.top.equalTo(top)
                    make.height.equalTo(0)
                }
            }
            top = stack.snp.bottom
        }
        self.layoutIfNeeded()
    }
    
    private  func configStackViews(){

        var top = self.snp.top
        for stackCount in 0..<LayoutManager.verticalMax{
            let stack = UIStackView()
            stack.alignment = .fill
            stack.axis = .horizontal
            stack.spacing = layout.imageMargin
            stack.distribution = .fillEqually
            
            for _ in 0..<layout.imageHorizontalCount {
                let imageView = UIImageView()
                imageView.contentMode = .scaleToFill
                stack.addArrangedSubview(imageView)
                imageViews.append(imageView)
            }
            
            stackHorizontalViews.append(stack)
            
            self.addSubview(stack)
            stack.snp.makeConstraints { (make) in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                if stackCount == 0{
                    make.top.equalTo(top)
                }else{
                    make.top.equalTo(top).offset(layout.imageMargin)
                }
                make.height.equalTo(layout.stackHeight())
                if stackCount == LayoutManager.verticalMax - 1{
                    make.bottom.equalToSuperview()
                }
            }
            top = stack.snp.bottom
        }
        
        let menuItemTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap(gestureRecognizer:)))
        menuItemTapGestureRecognizer.numberOfTouchesRequired = 1
        menuItemTapGestureRecognizer.numberOfTapsRequired = 1
        self.addGestureRecognizer(menuItemTapGestureRecognizer)


    }
    
    @objc private func  handleImageViewTap(gestureRecognizer:UITapGestureRecognizer){
        let tappedPoint = gestureRecognizer.location(in: self)
        
        if let imageView =   self.hitTest(tappedPoint, with: nil) as? UIImageView{
            let index = (imageViews as NSArray).index(of: imageView)
            guard  index < dataSource.count , index > 0 else {return}
            self.delegate?.didTapImages(index: index,model: dataSource[index])
        }

    }
    

}
extension HomeImageVIews{
    enum Column:Int {
        case single = 1
        case double = 2
        case three = 3
        func scale()->CGFloat{
            var height : CGFloat
            switch self {
            case .single:
                height = 0.45
            case .double:
                height = 1
            case .three:
                height = 1
            }
            return height
        }
    }

    struct LayoutManager {
        /// 最大横向数量
        static let horizontalMax : Int = 3
        /// 最大竖向数量
        static let verticalMax : Int = 3
        
        /// 元素间距离
        var imageMargin: CGFloat = 4
        
        /// 实际横向图片数量
        private(set) var imageHorizontalCount: Int = 0
        
        /// 实际竖向图片数量
        private(set) var imageVerticalCount: Int = 0
        
        /// 图片宽高比 图片排列方式
        private(set) var column: Column = .single
        /// 最大宽度
        private(set) var maxWidth: CGFloat = 0

        
        init(column:Column , maxWidth:CGFloat )  {
            imageHorizontalCount = column.rawValue
            self.column = column
            self.maxWidth = maxWidth
        }
        func numberOfRow(count:Int)->Int{
            
            return  Int(ceil(Float(count)/Float(imageHorizontalCount)))

        }
        func stackHeight() -> CGFloat{
            let columnValue : CGFloat = CGFloat(column.rawValue)
            let marginWidth : CGFloat = ( columnValue - 1) * imageMargin
            
            let imageWidth : CGFloat = (maxWidth - marginWidth) / columnValue
            let imageHeight : CGFloat = imageWidth * column.scale()
            return imageHeight
        }
        
    }

}
