//
//  HomeImageVIewsDome.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/1.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit


class HomeImageVIewsDome: UIView {


    weak var delegate : HomeImageVIewsActionDelegate?
    private  var layout :LayoutManager = LayoutManager(imageCount: 1)

    private static let verticalMax:Int = 3
    private var images : [String] = []
    private var imageViews : [UIImageView] = []
    private var horizontalCount: Int = 1
    private var dataSource: [HomeImageData] = []
    private var stackHorizontalViews: [UIStackView] = []

    private lazy var stackVerticalViews: UIStackView = UIStackView().then{
        $0.alignment = .fill
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = layout.imageMargin

    }

    convenience init(imageCount:Int) {
        self.init()
        layout = LayoutManager(imageCount: imageCount)

        configStackViews(count: imageCount)
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
    }
    
    private  func configStackViews(count:Int){
        self.addSubview(stackVerticalViews)

        for _ in 0..<layout.imageVerticalCount{
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
            stackVerticalViews.addArrangedSubview(stack)
        }
        
        let menuItemTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap(gestureRecognizer:)))
        menuItemTapGestureRecognizer.numberOfTouchesRequired = 1
        menuItemTapGestureRecognizer.numberOfTapsRequired = 1
        self.addGestureRecognizer(menuItemTapGestureRecognizer)

        stackVerticalViews.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(stackVerticalViews.snp.width).multipliedBy(layout.imageScale.scale())
        }
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
extension HomeImageVIewsDome{
    struct LayoutManager {
        enum ImageHeight{
            case single
            case two
            case three
            init(horizontalCount:Int) {
                switch horizontalCount {
                case 1:
                    self = .single
                case 2:
                    self = .two
                case 3:
                    self = .three
                default:
                    self = .three
                }
            }
            func scale()->CGFloat{
                var height : CGFloat
                switch self {
                case .single:
                    height = 0.45
                case .two:
                    height = 1
                case .three:
                    height = 2
                }
                return height
            }
        }
        
        
        /// 最大竖向数量
        static let verticalMax : Int = 3
        
        /// 元素间距离
        var imageMargin: CGFloat = 4
        
        /// 实际横向图片数量
        private(set) var imageHorizontalCount: Int = 0
        
        /// 实际竖向图片数量
        private(set) var imageVerticalCount: Int = 0
        
        /// 与图片数量相关的view高宽比
        private(set) var imageScale: ImageHeight = .single
        
        
        init(imageCount:Int) {
            var vertical = 1
            var horizontal = 1
            switch imageCount {
            case 1:
                /// 单图
                vertical = 1
                horizontal = 1
            /// 偶数 双列图片
            case 2,4:
                vertical = Int( roundf(Float( Float (imageCount) / 2.0)))
                horizontal = 2
                
            /// 奇数 三列图片
            case 3,5,6,7,8,9:

                vertical = Int( roundf(Float( Float (imageCount) / 3.0)))
                horizontal = 3
                
            default:
                /// 单图
                vertical = 1
                horizontal = 1
            }
            imageHorizontalCount = horizontal
            imageVerticalCount = vertical > LayoutManager.verticalMax ? LayoutManager.verticalMax : vertical
            imageScale = ImageHeight(horizontalCount: horizontal)
        }
    }

}
