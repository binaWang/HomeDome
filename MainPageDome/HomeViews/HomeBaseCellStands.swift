//
//  HomeBaseCellStands.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/28.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit


protocol HomeBaseCellData {
    func cellType()->HomeBaseCellStands.Type
}

protocol HomeBaseCellStands:UITableViewCell {
    func setData(_ data: HomeBaseCellData)
    func addViews()
    func layoutViews()
}
protocol HomeBaseCellActions: NSObjectProtocol {
    
}
