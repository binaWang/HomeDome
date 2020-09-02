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
}
extension HomeDataModel.Images:HomeImageData{
    var image: String? {
        return str
    }
    
    
}
extension HomeDataModel:HomeTotalCellData{
    var videoImageStr: String {
        videoimage
    }
    
    var videoURL: String {
        url
    }
    
    var imageDatas: [HomeImageData] {
        return imageArray
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


class HomeTableViewController: UITableViewController {
    var dataSource  :  [HomeBaseCellData] = []
    static let kPlayerViewTag = 10086
    lazy var controlView : ZFPlayerControlView = ZFPlayerControlView().then{
        $0.prepareShowLoading = true
        $0.prepareShowControlView = true
    }
    var player :  ZFPlayerController = ZFPlayerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
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
        for _  in 0...10{
            var model =  HomeDataModel()
            model.title = String.random(ofLength: 30)
            model.content = String.random(ofLength: 50)
            model.collection = "\(Int.random(in: 0...999))"
            model.like = "\(Int.random(in: 0...999))"
            model.read = "\(Int.random(in: 0...999))"
            var images:[HomeDataModel.Images] = []
            for _ in 0...Int.random(in: 0...9){
                var image =  HomeDataModel.Images()
                image.str = "\(Int.random(in: 0...7))"
                images.append(image)
            }
            model.url = "wewe"
            model.imageArray = images
            dataSource.append(model)
        }

        print(dataSource)
        
    }

    func initPlayer(){
        let playerManager =  ZFIJKPlayerManager()
        
        player = ZFPlayerController(scrollView: tableView, playerManager: playerManager, containerViewTag: HomeTableViewController.kPlayerViewTag)
        player.controlView = controlView
        player.shouldAutoPlay = false
        player.playerDisapperaPercent = 1.0
        
        player.orientationWillChange = {(player,isFullScreen) in
            ///
        }
        player.playerDidToEnd = {[weak self]asset in
            self?.player.stopCurrentPlayingCell()
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

    func playTheVideoAt(indexPath: IndexPath,scrollAnimated animated:Bool){
//        let model = dataSource[indexPath.row]
        let title = ""
        let url =  URL(fileURLWithPath: "")
        if animated {
            player.playTheIndexPath(indexPath, assetURL: url, scrollPosition: .top, animated: true)
            
        }else{
            player.playTheIndexPath(indexPath, assetURL: url)
        }
        controlView.showTitle(title, coverURLString: "url", fullScreenMode: .landscape)
    }
}
// MARK: - scrollView view delegate
extension HomeTableViewController{
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidEndDecelerating()
    }
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.zf_scrollViewDidEndDraggingWillDecelerate(decelerate)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidScroll()
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewWillBeginDragging()
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
        print(cell)

        cell.setData(model)
        return cell
    
    }
}
extension HomeTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.player.playingIndexPath != indexPath{
            player.stopCurrentPlayingCell()
        }
        if !self.player.currentPlayerManager.isPlaying{
            playTheVideoAt(indexPath: indexPath, scrollAnimated: false)
        }
    }
}
