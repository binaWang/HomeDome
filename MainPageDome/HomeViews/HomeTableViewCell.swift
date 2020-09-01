//
//  HomeTableViewCell.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/31.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell ,HomeCellStands{
    
    
    var column:HomeImageVIews.Column {
        get{
            return .single
        }
    }
    
    lazy var imageViews: HomeImageVIews = HomeImageVIews(maxWidth: kScreenWith  - 60, colum: column)

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

class  HomeDoubleColumnImageCell: HomeTableViewCell {
    override var column:HomeImageVIews.Column {
            return .double
    }

}

class  HomeThreeColumnImageCell: HomeTableViewCell {
    override var column:HomeImageVIews.Column {
            return .three
    }

}
