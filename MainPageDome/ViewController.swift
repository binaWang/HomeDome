//
//  ViewController.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/19.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addPageMenu()
//        custom()
        customPag()
//        abc()
    }
    func abc(){
        let view2 = UIView.init()
        view.addSubview(view2)
        view2.backgroundColor = UIColor.red
        view2.frame = CGRect ( x: 129, y: 232, width: 323, height: 123)
        let bezierPath = UIBezierPath(roundedRect: view2.bounds, byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.topRight], cornerRadii: CGSize(width: 15, height: 15))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 0
        view2.layer.insertSublayer(shapeLayer, at: 0)

    }
    func customPag(){
        let titles = ["1","22","333","4444","55555","666666","77777777","888888881"]
        let controllers =  titles.map{ title -> UIViewController in
            let vc = HomeTableViewController()
            if title == "4444"{
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
        view.addSubview(custom.view)
        custom.view.snp.makeConstraints { (make) in
            make.leading.equalTo(0  )
            make.trailing.equalTo(0)
            make.top.equalTo(100)
            make.bottom.equalTo(0)
        }
        custom.didMove(toParent: self)

    }
    func custom(){
        let scroll = UIScrollView()
        view.addSubview(scroll)

        scroll.snp.makeConstraints { (make) in
            make.leading.equalTo(0  )
            make.trailing.equalTo(0)
            make.top.equalTo(100)
            make.bottom.equalTo(0)
        }
        let contentView = UIView()
        scroll.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.leading.equalTo(scroll.snp.leading)
            make.trailing.equalTo(scroll.snp.trailing)
            make.top.equalTo(scroll.snp.top)
            make.bottom.equalTo(scroll.snp.bottom)
//            make.width.equalTo(scroll.snp.width)
            make.height.equalTo(scroll.snp.height)

        }
        var leading = contentView.snp.leading

        for index in 0...10{
            let sub = UIView()
            sub.backgroundColor = UIColor.random()
            contentView.addSubview(sub)
            sub.snp.makeConstraints { (make) in
                make.leading.equalTo(leading)
                make.top.equalTo(contentView.snp.top)
                make.width.equalTo(scroll.snp.width)
                make.bottom.equalTo(contentView.snp.bottom)
                if index == 10{
                    make.trailing.equalTo(contentView.snp.trailing)
                }
            }
            leading = sub.snp.trailing
        }
    }
    func addPageMenu(){
        let titles = ["1","22","333","4444","55555","666666","77777777","888888881"]
        let controllers =  titles.map{ title -> UIViewController in
            let vc = NewViewController()
            vc.title = title
            vc.view.backgroundColor = UIColor.random()
            return vc
        }


        let pageMenu = CAPSPageMenu(viewControllers: controllers, frame:  CGRect.zero, options: [:])!
        self.addChild(pageMenu)
        view.addSubview(pageMenu.view)
        pageMenu.view.snp.makeConstraints { (make) in
            make.leading.equalTo(0  )
            make.trailing.equalTo(0)
            make.top.equalTo(100)
            make.bottom.equalTo(0)
        }
//        pageMenu.addPage(at: <#T##Int#>)
        pageMenu.didMove(toParent: self)
    }


}

