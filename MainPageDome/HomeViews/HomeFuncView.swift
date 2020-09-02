//
//  HomeFuncview.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/25.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
protocol HomeFuncViewData {
    var readCount: String?{get}
    var timeString: String?{get}
    var collectionCount: String?{get}
    var likeCount: String?{get}

}
protocol HomeFuncViewProtocol : UITableViewCell{
    var funcView : HomeFuncView{get set}

}
extension HomeFuncViewProtocol where Self : UITableViewCell{

}
protocol HomeFuncViewDelegate: NSObjectProtocol {
    func didTapFuncViewAction(type:HomeFuncView.TapType)
}

extension HomeFuncViewDelegate where Self : HomeImageCellStands{
    func didTapFuncViewAction(type:HomeFuncView.TapType){
        self.delegate?.didTapFuncView(type: type)
    }
}
class HomeFuncView: UIView {
    enum TapType {
        case read
        case collection
        case like
    }
    weak var delegate  : HomeFuncViewDelegate?
    let dispose = DisposeBag()
    static let height: CGFloat = 12
     private var timeLabel : UILabel = UILabel().then{
        $0.font =   UIFont.svwPingFangSC_Medium(ofSize:12)
        $0.textColor =   MosCommonColor.app_assist_detail
    }

     private var readBtn : UIButton = UIButton().then{
        $0.setTitleColor(MosCommonColor.app_assist_detail, for: .normal)
        $0.titleLabel?.font =  UIFont.svwPingFangSC_Medium(ofSize:12)
        $0.setImage(UIImage(named: "Home_watch"), for: .normal)
    }
    private var collectionBtn : UIButton = UIButton().then{
        $0.setTitleColor(MosCommonColor.app_assist_detail, for: .normal)
        $0.titleLabel?.font =  UIFont.svwPingFangSC_Medium(ofSize:12)
        $0.setImage(UIImage(named: "Home_talk"), for: .normal)

    }
    private var likeBtn : UIButton = UIButton().then{
        $0.setTitleColor(MosCommonColor.app_assist_detail, for: .normal)
        $0.titleLabel?.font =  UIFont.svwPingFangSC_Medium(ofSize:12)
        $0.setImage(UIImage(named: "Home_like_select"), for: .normal)
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubView()
        
    }
    func setData(data: HomeFuncViewData){
        timeLabel.text = data.timeString
        readBtn.setTitle(data.readCount, for: .normal)
        collectionBtn.setTitle(data.collectionCount, for: .normal)
        likeBtn.setTitle(data.likeCount, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configSubView(){
        addSubview(timeLabel)

        addSubview(readBtn)
        addSubview(collectionBtn)
        addSubview(likeBtn)
        
        timeLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        
        readBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(HomeFuncView.height)
            make.trailing.equalTo(collectionBtn.snp.leading).offset(-26)

        }
        collectionBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(readBtn)
            make.trailing.equalTo(likeBtn.snp.leading).offset(-26)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(readBtn)
            make.trailing.equalToSuperview()
        }
        
        readBtn.rx.tap.subscribe(onNext: { [weak self]_ in
            self?.delegate?.didTapFuncViewAction(type: .read)
        }).disposed(by: dispose)
        
        collectionBtn.rx.tap.subscribe(onNext: { [weak self]_ in
            self?.delegate?.didTapFuncViewAction(type: .collection)
        }).disposed(by: dispose)

        likeBtn.rx.tap.subscribe(onNext: { [weak self]_ in
            self?.delegate?.didTapFuncViewAction(type: .like)
        }).disposed(by: dispose)

    }
}
