//
//  CustomScrollView.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/20.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
import SnapKit
class PageMenuScrollView: UIScrollView {
    var contentView  = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
