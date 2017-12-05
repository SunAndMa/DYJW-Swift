//
//  FKBaseController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/20.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

fileprivate let navigationOffset = navigationBarHeight - 44.0

class FKBaseController: UIViewController {
    
    override var title: String? {
        get {
            return self.navigationController?.title
        }
        set {
            self.navigationController?.title = newValue
        }
    }
    
    override var navigationController: BaseNavigationController? {
        get {
            if let tabController = self.tabBarController as? DrawerTabController {
                return tabController.navigationController
            } else {
                return super.navigationController as? BaseNavigationController
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.grey50
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = super.title
    }
    
    override func viewWillLayoutSubviews() {
        self.view.frame = CGRect(x: 0,
                                 y: navigationBarHeight + statusBarHeight,
                                 width: Screen.width,
                                 height: Screen.height - navigationBarHeight - statusBarHeight)
//        self.view.frame = CGRect(x: 0,
//                                 y: navigationOffset,
//                                 width: Screen.width,
//                                 height: Screen.height - navigationOffset)
    }
    
    override func viewDidLayoutSubviews() {
        self.view.frame = CGRect(x: 0,
                                 y: navigationBarHeight + statusBarHeight,
                                 width: Screen.width,
                                 height: Screen.height - navigationBarHeight - statusBarHeight)
//        self.view.frame = CGRect(x: 0,
//                                 y: navigationOffset,
//                                 width: Screen.width,
//                                 height: Screen.height - navigationOffset)
    }
    
}
