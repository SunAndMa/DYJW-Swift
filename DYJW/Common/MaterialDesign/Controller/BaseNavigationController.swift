//
//  MDToolbarController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/19.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

public let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
public let navigationBarHeight: CGFloat = 56
public let isIphoneX: Bool = Screen.width / Screen.height < 375.0 / 667.0

class BaseNavigationController: UINavigationController {
    
    override var title: String? {
        get {
            return self.titleLabel.text
        }
        set(value) {
            self.titleLabel.text = value
        }
    }
    
    fileprivate let navigationBackgroundLayer = CALayer()
    fileprivate let statusBarBackgroundLayer = CALayer()
    
    fileprivate let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setNavigationBarStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var frame = self.navigationBar.frame
        frame.size.height = navigationBarHeight
        self.navigationBar.frame = frame
    }
    
    fileprivate func setNavigationBarStyle() {
        
        var frame = self.navigationBar.frame
        frame.size.height = statusBarHeight + navigationBarHeight
        frame.origin.y = -statusBarHeight
        self.navigationBackgroundLayer.frame = frame
        self.navigationBackgroundLayer.backgroundColor = UIColor.lightBlue500.cgColor
        self.navigationBar.layer.addSublayer(self.navigationBackgroundLayer)
        
        if !isIphoneX {
            frame.size.height = statusBarHeight
            self.statusBarBackgroundLayer.frame = frame
            self.statusBarBackgroundLayer.backgroundColor = UIColor.lightBlue600.cgColor
            self.navigationBar.layer.addSublayer(self.statusBarBackgroundLayer)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        titleLabel.frame = CGRect(x: 56, y: 0, width: Screen.width - 112, height: 56)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 22)
    }
    
}
