//
//  HomeTableViewController.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/25.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
import SwifterSwift
import ZFPlayer
struct HomeDataModel {
    struct Images {
        var str:String = ""
    }
    

    var title:String = ""
    var content : String = ""
    var read:String = ""
    var collection:String = ""
    var like:String = ""
    var imageArray:[Images] = []
    var url : String = ""
    var videoimage : String = ""
    var time:String = ""
}
extension HomeDataModel.Images:HomeColumnData{
    var imageString: String? {
        return str

    }
    
    var titleString: String? {
        return "111"
    }
    
    
    
}
extension HomeDataModel:HomeTotalCellData{
    var columnDatas: [HomeColumnData] {
        imageArray
    }
    
    var timeString: String? {
        time
    }
    
    var videoImageStr: String {
        videoimage
    }
    
    var videoURL: String {
        url
    }
    
    
    var titleText: String? {
        return title
    }
    
    var contentText: String? {
        return content
    }
    
    var readCount: String? {
        return read
    }
    
    var collectionCount: String? {
        return collection
    }
    
    var likeCount: String? {
        return like
    }
}


class HomeTableViewController: UITableViewController ,TableViewPlayerProtocol{
    var dataSource  :  [HomeBaseCellData] = []
    static let kPlayerViewTag = 10086
    lazy var controlView : ZFPlayerControlView = ZFPlayerControlView()
    var player :  ZFPlayerController = ZFPlayerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellWithClass: HomeVideoTableViewCell.self)
        tableView.register(cellWithClass: HomeSingleColumnViewCell.self)
        tableView.register(cellWithClass: HomeDoubleColumnImageCell.self)
        tableView.register(cellWithClass: HomeThreeColumnImageCell.self)
        if #available(iOS 11.0, * ){
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        for i  in 0...10{
            var model =  HomeDataModel()
            model.title = String.random(ofLength: 89)
            model.content = String.random(ofLength: 300)
            model.collection = "\(Int.random(in: 0...999))"
            model.like = "\(Int.random(in: 0...999))"
            model.read = "\(Int.random(in: 0...999))"
            model.time = "\(Int.random(in: 0...10))分钟前"
            var images:[HomeDataModel.Images] = []
            for _ in 0...Int.random(in: 0...9){
                var image =  HomeDataModel.Images()
                image.str = "\(Int.random(in: 0...7))"
                images.append(image)
            }
            if i % 3 == 0{
                model.url = "wewe"
            }
            model.imageArray = images
            dataSource.append(model)
        }
        print(dataSource)
        initPlayerView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.player.isViewControllerDisappear = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.player.isViewControllerDisappear = true
    }

}
// MARK: - Table view data source
extension HomeTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        let classType = model.cellType()
        print(classType)
        guard let cell = tableView.dequeueReusableCell(withClass: classType) as? HomeBaseCellStands else {
            fatalError("Couldn't find UITableViewCell ")
        }
        cell.setData(model, index: indexPath)
        cell.delegate  = self
        return cell
    
    }
}
extension HomeTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model  = dataSource[indexPath.row] as? HomeTotalCellData,
            model.videoURL != "",
            let url = URL(string: model.videoURL){
            playTheVideoAt(indexPath: indexPath, animated: false, assetURL: url, title: "", placeHoldImage: "")

        }
        
    }
}
extension HomeTableViewController: HomeCellDelegate{
    func didSelectAction(action: HomeCellActions, object: Any?) {
        
    }
    
    
    
    
}
