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
}
extension HomeDataModel.Images:HomeImageData{
    var image: String? {
        return str
    }
    
    
}
extension HomeDataModel:HomeCellStandsData{


    
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
//    var configs :HomeTableViewControllerConfig = HomeTableViewControllerConfig()
    var player :  ZFPlayerController = ZFPlayerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellWithClass: HomeTableViewCell.self)
        tableView.register(cellWithClass: HomeDoubleColumnImageCell.self)
        tableView.register(cellWithClass: HomeThreeColumnImageCell.self)
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
            model.imageArray = images
            dataSource.append(model)
        }

        print(dataSource)
        
    }

    func initPlayer(){
        let playerManager = 
        player
    }
    // MARK: - Table view data source

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
