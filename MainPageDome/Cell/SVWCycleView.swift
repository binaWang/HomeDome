//
//  CustomCycleView.swift
//  CustomCycleScrollView
//
//  Created by 王斌 on 2020/6/7.
//  Copyright © 2020 SVW. All rights reserved.
//

import UIKit
import Then
import SDCycleScrollView

protocol SVWCycleViewDelegate:NSObjectProtocol {
    
    func didSelectItemAt(index:Int)
}

class SVWCycleView: UIView {
    var pageControlHeight : CGFloat = 44
    weak var delegate: SVWCycleViewDelegate?
    private var dataSource : [String] = []
    private var collection : SDCycleScrollView
    private var pageContorl : TAPageControl
    override init(frame: CGRect) {
        pageContorl = TAPageControl()
        collection = SDCycleScrollView(frame: frame)
        
        
        super.init(frame: frame)
        
        
        configCollectionView()
        configPageContol()
        updateSubConstraints()
    }
    func setDatas(models : [String]){
        collection.imageURLStringsGroup = models
        dataSource = models
        pageContorl.numberOfPages = dataSource.count
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        pageContorl.sizeToFit()

    }
    private func configPageContol(){
        pageContorl.hidesForSinglePage = true
        pageContorl.dotViewClass = SVWCycleDotView.self
        pageContorl.currentPage = 0
        pageContorl.dotSize = CGSize(width: 4, height: 4)
        addSubview(pageContorl)
    }

    private func configCollectionView()  {
        collection.delegate = self
        collection.pageControlBottomOffset = -24
        collection.showPageControl = false
        collection.backgroundColor = UIColor.clear

        addSubview(collection)
        
    }
    required init?(coder: NSCoder) {
        fatalError(INIT_CODER_NIL_WARRNING)
    }
    func updateSubConstraints() {
        let scale:CGFloat = 540/1005
        let height = (kScreenWith - 32 ) * scale + 32
        self.collection.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(0)
            make.right.equalTo(self.snp.right)
            make.left.equalTo(self.snp.left)
            make.height.equalTo(height)
            
        })
        pageContorl.snp.makeConstraints { (make) in
            make.bottom.equalTo(collection.snp.bottom).offset(-20)
            make.right.equalTo(self.snp.right)
            make.left.equalTo(self.snp.left)
            make.height.equalTo(10)
        }

    }

}
//MARK: SDCycleScrollViewDelegate
extension SVWCycleView:SDCycleScrollViewDelegate{
    func customCollectionViewCellClass(for view: SDCycleScrollView!) -> AnyClass! {
        return SVWCycleCollectionCell.self
    }
    func setupCustomCell(_ cell: UICollectionViewCell!, for index: Int, cycleScrollView view: SDCycleScrollView!) {
        if let custom = cell as? SVWCycleCollectionCell{
            custom.setData(image: dataSource[index])
        }
    }
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didScrollTo index: Int) {
        self.pageContorl.currentPage = index
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        self.delegate?.didSelectItemAt(index: index)
    }
    
    
}
