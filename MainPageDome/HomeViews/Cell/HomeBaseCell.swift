//
//  HomeBaseCell.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/4.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class HomeBaseCell: UITableViewCell,HomeBaseCellStands {
    
    var delegate: HomeCellDelegate?
    
    var indexPath: IndexPath?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: HomeBaseCellData, index: IndexPath) {
        self.indexPath = index

    }
    
    func addViews() {
        fatalError("Couldn't User that ")

    }
    
    func layoutViews() {
        fatalError("Couldn't User that ")

    }

}
