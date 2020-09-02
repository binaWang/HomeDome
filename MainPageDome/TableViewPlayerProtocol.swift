//
//  TableViewPlayerProtocol.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/1.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
import ZFPlayer

protocol TableViewPlayerProtocol : UITableViewController{
    static var kPlayerViewTag :Int {get}

    var player:ZFPlayerController{get set}
    var controlView:ZFPlayerControlView{get set}
    func initPlayerView()
    func playTheVideoAt(indexPath: IndexPath, animated:Bool,assetURL:URL,title:String,placeHoldImage:String)
}
extension TableViewPlayerProtocol where Self : UITableViewController{
    func initPlayerView(){
        initControlView()
        initPlayer()
    }

    func initPlayer(){
        let playerManager =  ZFIJKPlayerManager()
        
        player = ZFPlayerController(scrollView: tableView, playerManager: playerManager, containerViewTag: Self.kPlayerViewTag)
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
    func initControlView(){
        controlView = ZFPlayerControlView()
        controlView.prepareShowLoading = true
        controlView.prepareShowControlView = true
    }
    func playTheVideoAt(indexPath: IndexPath, animated:Bool,assetURL:URL,title:String,placeHoldImage:String){        
        if animated {
            player.playTheIndexPath(indexPath, assetURL: assetURL, scrollPosition: .top, animated: true)
            
        }else{
            player.playTheIndexPath(indexPath, assetURL: assetURL)
        }
        controlView.showTitle(title, coverURLString: placeHoldImage, fullScreenMode: .landscape)

    }

}
// MARK: - TableViewPlayerCellDelegate  delegate
extension TableViewPlayerProtocol where Self : UITableViewController{
    
    func playVideoAt(indexPath:IndexPath,assetURL:URL,title:String,placeHoldImage:String){
        playTheVideoAt(indexPath: indexPath, animated: false, assetURL: assetURL, title: title, placeHoldImage: placeHoldImage)
    }

}
// MARK: - scrollView view delegate
extension TableViewPlayerProtocol where Self : UITableViewController{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidEndDecelerating()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.zf_scrollViewDidEndDraggingWillDecelerate(decelerate)
    }
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidScroll()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewWillBeginDragging()
    }

}
