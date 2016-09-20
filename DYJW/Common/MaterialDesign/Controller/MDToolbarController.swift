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
    var screenSize: CGSize = UIScreen.mainScreen().bounds.size
    private let statusBarBgLayer = CALayer.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setNavigationBarStyle()
    }
    
    override func viewDidAppear(animated: Bool) {
        var frame = self.navigationBar.frame
        frame.size.height = toolbarHeight - statusBarHeight
        self.navigationBar.frame = frame
    }
    
    private func setNavigationBarStyle() {
        self.navigationBar.setBackgroundImage(UIColor.pureColorImage(UIColor.lightBlue500(), size: CGSize(width: screenSize.width, height: toolbarHeight)), forBarMetrics: UIBarMetrics.Default)
        self.navigationBar.shadowImage = UIImage.init()
        statusBarBgLayer.frame = CGRect(x: 0, y: -statusBarHeight, width: screenSize.width, height: statusBarHeight)
        statusBarBgLayer.backgroundColor = UIColor.lightBlue600().CGColor
        self.navigationBar.layer.addSublayer(statusBarBgLayer)
    }

    override func viewWillLayoutSubviews() {
        screenSize = UIScreen.mainScreen().bounds.size
        statusBarBgLayer.frame = CGRect(x: 0, y: -statusBarHeight, width: screenSize.width, height: statusBarHeight)
    }
    
}
