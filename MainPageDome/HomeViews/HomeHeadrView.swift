//
//  HomeHeadrView.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/3.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
import Kingfisher
protocol HomeHeadrViewDatas {
    var userNameString:String?{get}
    var userImageString:String?{get}
    var userString:String?{get}
    var userContentString:String?{get}
    var isfollow:Bool?{get}
}

protocol HomeHeadrViewProtocol: UITableViewCell {
    var usersInfo: HomeHeadrView {get set}
}
protocol HomeHeadrViewActionDelegate: NSObjectProtocol {
    func didTapFollowButton()
}

class HomeHeadrView: UIView {
    
    weak var delegate : HomeHeadrViewActionDelegate?

    private var imageView: UIImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
    }
    private var imageTag: UIImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit

    }
    private var nameLabel: UILabel = UILabel().then{
        $0.textColor = MosCommonColor.app_assist_dark_black
        $0.font = UIFont.svwPingFangSC_Medium(ofSize:14)
    }
    private var contentLabel: UILabel = UILabel().then{
        $0.textColor =   MosCommonColor.app_assist_detail
        $0.font = UIFont.svwPingFangSC_Medium(ofSize:14)
    }

    private var nameTagImageView: UILabel =  UILabel().then{
           $0.contentMode = .scaleAspectFit
       }
    private var followButton: UIButton = UIButton().then{
        $0.setTitle("关注", for: .normal)
        $0.setTitle("已关注", for: .selected)
        $0.setTitleColor(MosCommonColor.app_main_blue, for: .normal)
        $0.setTitleColor(MosCommonColor.app_assist_detail, for: .selected)
        $0.setBackgroundImage(UIImage(color: UIColor(hexString: "#EDF9FD")!, size: CGSize(width: 56, height: 28)), for: .selected)
        $0.setBackgroundImage(UIImage(color: MosCommonColor.app_background, size: CGSize(width: 56, height: 28)), for: .normal)
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubViws()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(data:HomeHeadrViewDatas){
        if let  str = data.userImageString,let url = URL(string: str){
            imageView.kf.setImage(with: url)
        }
        nameLabel.text = data.userNameString
        contentLabel.text = data.userContentString

        followButton.isSelected = data.isfollow == true
        
    }
    @objc private func followAction(){
        self.delegate?.didTapFollowButton()
    }
    
    private func configSubViws(){
        addSubview(imageView)
        imageView.addSubview(imageTag)
        addSubview(nameLabel)
        addSubview(contentLabel)
        addSubview(nameTagImageView)
        addSubview(followButton)
        followButton.addTarget(self, action: #selector(followAction), for: .touchUpInside)
        let imageWidth : CGFloat = 35
        imageView.cornerRadius = imageWidth / 2.0
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: imageWidth, height: imageWidth))
            make.leading.equalToSuperview()
        }
        
        imageTag.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 12, height: 12))
            make.trailing.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.bottom.equalTo(imageView.snp.bottom).offset(-imageWidth / 2.0)
            make.width.lessThanOrEqualTo(followButton.snp.leading).offset(50)
        }
        nameTagImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel.snp.trailing).offset(4)
            make.size.equalTo(CGSize(width: 40, height: 12))
            make.centerY.equalTo(imageView.snp.centerY).offset(0)
        }

        contentLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel.snp.leading).offset(0)
            make.bottom.equalTo(imageView.snp.bottom).offset(0)
            make.width.lessThanOrEqualTo(followButton.snp.leading).offset(5)
        }
        followButton.cornerRadius = 14
        followButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.size.equalTo(CGSize(width: 56, height: 28))
            make.centerY.equalTo(imageView.snp.centerY).offset(0)
        }
    }

}
