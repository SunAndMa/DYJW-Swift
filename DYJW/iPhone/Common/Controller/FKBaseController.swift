//
//  FKBaseController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/20.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

class FKBaseController: UIViewController {
    
    var screenSize: CGSize = UIScreen.main.bounds.size
    
    override var title: String? {
        get {
            if self.navigationController != nil {
                return self.navigationController!.title
            } else {
                return ""
            }
        }
        set(value) {
            if self.navigationController != nil {
                self.navigationController!.title = value
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.grey50()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        screenSize = UIScreen.main.bounds.size
        self.view.frame = CGRect(x: 0, y: 76, width: screenSize.width, height: screenSize.height - 76)
    }
    
}
