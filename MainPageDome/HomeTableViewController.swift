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
import MJRefresh
struct HomeDataModel {
    struct Images {
        var str:String = ""
        var title : String = ""
        
    }
    

    var custom:Int = 0
    var title:String = ""
    var content : String = ""
    var read:String = ""
    var collection:String = ""
    var like:String = ""
    var imageArray:[Images] = []
    var url : String = ""
    var videoimage : String = ""
    var time:String = ""
    var avtive:String = ""
    var address:String = ""
    var state:String = ""
    var name:String = ""
    var nameContent:String = ""
    var follow:String = ""
    var more:String = ""
}
extension HomeDataModel.Images:HomeColumnData{
    var titleString: String? {
        return title
    }
    
    var imageString: String? {
        return str

    }
    
    
    
    
}
extension HomeDataModel:HomeTotalCellData{
    var userNameString: String? {
        name
    }
    
    var userImageString: String? {
        return "1"
    }
        
    var userContentString: String? {
        nameContent
    }
    
    var isfollow: Bool? {
        follow == "1"
    }
    
    var userViewImageStr: String? {
        return "4"
    }
    
    var activeImage: String? {
        return "1"
    }
    
    var customType: Int {
        return custom
    }
    
    var activeTitleString: String? {
        avtive
    }
    
    var addressString: String? {
        address
    }
    
    var stateType: String? {
        state
    }
    
    var moreTitle: String? {
        more
    }
    
    var showMoreButton: Bool? {
        self.imageArray.count > 4
    }
    
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
        tableView.register(cellWithClass: HomeADCell.self)
        tableView.register(cellWithClass: HomeActiveCell.self)
        tableView.register(cellWithClass: HomeRecommendCell.self)
        tableView.register(cellWithClass: HomeUserSingleColumnViewCell.self)
        tableView.register(cellWithClass: HomeUserDoubleColumnImageCell.self)
        tableView.register(cellWithClass: HomeUserThreeColumnImageCell.self)
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(beginData))
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(requestData))
        if #available(iOS 11.0, * ){
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }

        initPlayerView()
        
    }
    func creataData( data:@escaping (([HomeBaseCellData])->())){
        DispatchQueue.global().async {
            var array : [HomeBaseCellData] = []
            for i  in 0...10{
            var model =  HomeDataModel()
            model.title = String.random(ofLength: 89)
            model.content = String.random(ofLength: 300)
            model.more = String.random(ofLength: 300)
            model.collection = "\(Int.random(in: 0...999))"
            model.like = "\(Int.random(in: 0...999))"
            model.read = "\(Int.random(in: 0...999))"
            model.custom = Int.random(in: 0...5)
            model.time = "\(Int.random(in: 0...10))分钟前"
            model.address = String.random(ofLength: 89)
            model.avtive =  String.random(ofLength: 89)
            model.name = String.random(ofLength: 30)
            model.nameContent = String.random(ofLength: 50)

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
                array.append(model)
            }
            DispatchQueue.main.async {
                data(array)
            }
        }
    }
    @objc func beginData(){
        tableView.mj_header.beginRefreshing()
        creataData { [weak self](data) in
            self?.dataSource =  data
            self?.tableView.reloadData()
            self?.tableView.mj_header.endRefreshing()

        }
    }
    @objc func requestData(){
        tableView.mj_footer.beginRefreshing()
        creataData { [weak self](data) in
            self?.dataSource.append(contentsOf: data)
            self?.tableView.reloadData()
            self?.tableView.mj_footer.endRefreshing()

        }

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
