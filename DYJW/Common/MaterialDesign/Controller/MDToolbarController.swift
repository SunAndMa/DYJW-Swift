//
//  MDToolbarController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/19.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

class MDToolbarController: UINavigationController {
    
    let toolbarHeight: CGFloat = 76
    let statusBarHeight: CGFloat = 20
    var screenSize: CGSize = UIScreen.main.bounds.size
    fileprivate let statusBarBgLayer = CALayer.init()
    let titleLabel: UILabel = UILabel.init()
    override var title: String? {
        get {
            return self.titleLabel.text
        }
        set(value) {
            self.titleLabel.text = value
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setNavigationBarStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var frame = self.navigationBar.frame
        frame.size.height = toolbarHeight - statusBarHeight
        self.navigationBar.frame = frame
        self.navigationBar.addSubview(titleLabel)
    }
    
    fileprivate func setNavigationBarStyle() {
        self.navigationBar.setBackgroundImage(UIColor.lightBlue500.pureColorImage(size: CGSize(width: screenSize.width, height: toolbarHeight)), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage.init()
        statusBarBgLayer.frame = CGRect(x: 0, y: -statusBarHeight, width: screenSize.width, height: statusBarHeight)
        statusBarBgLayer.backgroundColor = UIColor.lightBlue600.cgColor
        self.navigationBar.layer.addSublayer(statusBarBgLayer)
    }

    override func viewWillLayoutSubviews() {
        screenSize = UIScreen.main.bounds.size
        statusBarBgLayer.frame = CGRect(x: 0, y: -statusBarHeight, width: screenSize.width, height: statusBarHeight)
        titleLabel.frame = CGRect(x: 56, y: 0, width: screenSize.width - 112, height: 56)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 22)
    }
    
}
