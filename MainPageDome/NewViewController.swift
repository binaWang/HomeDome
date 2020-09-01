//
//  NewViewController.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/22.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        label.text = self.title
        label.textColor = UIColor.lightText
        label.textAlignment = .center
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
