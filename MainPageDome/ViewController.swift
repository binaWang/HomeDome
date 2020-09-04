//
//  ViewController.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/19.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
import SnapKit
import SDCycleScrollView
class ViewController: UIViewController {
    var currentPanY:CGFloat = 0
    var subScrollEnabled: Bool = false
    var mainScrollEnabled: Bool = false
    var maxOffsetY: CGFloat = 170.0
    var scrollView = HomeScrollView()
    var pageMenuControllers : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatScrollView()

        customPag()
    }
    func creatScrollView(){
        view.addSubview(scrollView)
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(recognizer:)))
        scrollView.alwaysBounceVertical = true
        scrollView.addGestureRecognizer(pan)
        pan.delegate = self

        scrollView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()

        }
        scrollView.contentView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }

    }
    func customPag(){
        
        let cycleView = SVWCycleView()
        cycleView.setDatas(models: ["1","2","3","4","5","6","7","0"])
        let height = kScreenWith * (540.0/1005.0)
        scrollView.cycleView = cycleView
        scrollView.contentView.addSubview(cycleView)
        cycleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
        scrollView.contentOffsetY = height
        let titles = ["推荐","资讯","活动","Image","23333","沙雕电影","白头神探","我是传奇"]
        let controllers =  titles.map{ title -> UIViewController in
            let vc = HomeTableViewController()
            if title == "Image"{
                vc.tabBarItem.image = UIImage(named: "7")
            }
            vc.title = title
            vc.view.backgroundColor = UIColor.random()
            return vc
        }

        var config  = MenuConfigModel()
        config.selectionIndicatorColor = MosCommonColor.universal_green ?? UIColor.white
        let custom = PageMenu(controllers: controllers,config: config)
        self.addChild(custom)
        scrollView.contentView.addSubview(custom.view)
        scrollView.pageMenu = custom

        custom.view.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(view.snp.height)
            make.bottom.equalToSuperview()
        }
        custom.didMove(toParent: self)

    }


    /// 自定义穿透手势
    @objc func panAction(recognizer:UIPanGestureRecognizer) {
        if recognizer.state != .changed{
            currentPanY = 0
            // 每次滑动结束都清空状态
            mainScrollEnabled = false
            subScrollEnabled = false
        }else {
            let currentY = recognizer.translation(in: scrollView).y
            // 说明在这次滑动过程中经过了临界点
            if mainScrollEnabled || subScrollEnabled  {
                if currentPanY == 0 {
                    currentPanY = currentY  //记录下经过临界点是的 y
                }
                let offsetY = currentPanY - currentY //计算在临界点后的 offsetY
                
                if mainScrollEnabled {
                    let supposeY = maxOffsetY + offsetY
                    if supposeY > 0 {
                        scrollView.contentOffset = CGPoint(x: 0, y: supposeY)
                    }else {
                        scrollView.contentOffset = CGPoint.zero
                    }
                }else {
                }
            }
        }
    }
}

extension ViewController:UIGestureRecognizerDelegate{
    
}
