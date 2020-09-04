//
//  HomeSingleColumnViewCell.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/31.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class HomeSingleColumnViewCell: UITableViewCell ,HomeImageCellStands{
    
    var indexPath: IndexPath?
    
    var delegate: HomeCellDelegate?
    
    var inset: CGFloat = 16
    
    var column:HomeColumnVIews.Column {
        get{
            return .single
        }
    }
    
    lazy var columnView: HomeColumnVIews = HomeColumnVIews(maxWidth: kScreenWith  -  inset * 2, colum: column, itemType: ConsultantView.self)
    lazy var labelsView: HomeLabelsView =  HomeLabelsView()
    
    lazy var funcView: HomeFuncView = HomeFuncView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
class  HomeDoubleColumnImageCell: HomeSingleColumnViewCell {
    override var column:HomeColumnVIews.Column {
            return .double
    }

}

class  HomeThreeColumnImageCell: HomeSingleColumnViewCell {
    override var column:HomeColumnVIews.Column {
            return .three
    }

}

