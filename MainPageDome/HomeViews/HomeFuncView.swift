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
    var collectionCount: String?{get}
    var likeCount: String?{get}

}
protocol HomeFuncViewProtocol : UITableViewCell{
    var funcView : HomeFuncView{get set}
//    func addFuncView(top:SnapKit.ConstraintItem,offset:CGFloat)-> SnapKit.ConstraintItem

}
extension HomeFuncViewProtocol where Self : UITableViewCell{
//    func addFuncView(top:SnapKit.ConstraintItem,offset:CGFloat)-> SnapKit.ConstraintItem{
//        contentView.addSubview(funcView)
//        funcView.snp.makeConstraints { (make) in
//            make.leading.equalToSuperview().offset(0)
//            make.trailing.equalToSuperview().offset(0)
//            make.top.equalTo(top).offset(offset)
//        }
//        return funcView.snp.bottom
//    }

}
protocol HomeFuncViewDelegate: NSObjectProtocol {
    func didTapFuncViewAction(type:HomeFuncView.TapType)
}

extension HomeFuncViewDelegate where Self : UITableViewCell{
    func didTapFuncViewAction(type:HomeFuncView.TapType){
        
    }
}
class HomeFuncView: UIView {
    enum TapType {
        case read
        case collection
        case like
    }
    weak var delegate  : HomeFuncViewDelegate?
    static let height: CGFloat = 80
     private var readBtn : UIButton = UIButton().then{
        $0.setTitle("1234", for: .normal)
    }
    private var collectionBtn : UIButton = UIButton().then{
        $0.setTitle("1234", for: .normal)
    }
    private var likeBtn : UIButton = UIButton().then{
        $0.setTitle("1234", for: .normal)
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubView()
        
    }
    func setData(data: HomeFuncViewData){
        readBtn.setTitle(data.readCount, for: .normal)
        collectionBtn.setTitle(data.collectionCount, for: .normal)
        likeBtn.setTitle(data.likeCount, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configSubView(){
        addSubview(readBtn)
        addSubview(collectionBtn)
        addSubview(likeBtn)
        
        readBtn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(HomeFuncView.height)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(readBtn)
            make.trailing.equalTo(collectionBtn.snp.leading).offset(-10)
        }

        collectionBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(readBtn)
            make.trailing.equalToSuperview()
        }
        
        readBtn.rx.tap.subscribe(onNext: { [weak self]_ in
          
            self?.delegate?.didTapFuncViewAction(type: .read)
            
        }).dispose()
        collectionBtn.rx.tap.subscribe(onNext: { [weak self]_ in
          
            self?.delegate?.didTapFuncViewAction(type: .collection)
            
        }).dispose()

        likeBtn.rx.tap.subscribe(onNext: { [weak self]_ in
          
            self?.delegate?.didTapFuncViewAction(type: .like)
            
        }).dispose()

    }
}
