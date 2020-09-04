//
//  HomeCellProt.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/25.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
protocol HomeUserViewData {
    var userViewImageStr:String? { get  }
    
}
protocol HomeUserViewProtocol : UITableViewCell {
    var userView:HomeUserView{get set}
}

class HomeUserView: UIView {
    private var userAvatar : UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userAvatar)
        
        userAvatar.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(0)
//            make.trailing.equalToSuperview().offset(0)
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.bottom.equalToSuperview()
        }
    }
    func setData( data: HomeUserViewData){
        if let image = data.userViewImageStr{
            userAvatar.image = UIImage(named: image)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
