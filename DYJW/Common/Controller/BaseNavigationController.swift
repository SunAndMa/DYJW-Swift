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
        set {
            self.titleLabel.text = newValue
        }
    }
    
    fileprivate let navigationBackgroundLayer = CALayer()
    fileprivate let statusBarBackgroundLayer = CALayer()
    
    fileprivate let hamburger: HamburgerView = HamburgerView()
    fileprivate let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setNavigationBarStyle()
        self.setupHamburgerView()
        self.setupTitleLabel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
    
    fileprivate func setupHamburgerView() {
        self.navigationBar.addSubview(self.hamburger)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hamburgerClick))
        self.hamburger.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func hamburgerClick() {
        if self.hamburger.state == .normal {
            self.hamburger.state = .back;
            let app: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            app.openDrawer()
        } else {
            if (self.hamburger.state == .popBack) {
                self.popViewController(animated: true)
            }
            self.hamburger.state = .normal;
            let app: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            app.closeDrawer()
        }
    }
    
    fileprivate func setupTitleLabel() {
        self.titleLabel.frame = CGRect(x: self.hamburger.width,
                                       y: 0,
                                       width: Screen.width - self.hamburger.width,
                                       height: navigationBarHeight)
        self.titleLabel.font = UIFont.systemFont(ofSize: 22)
        self.titleLabel.textColor = UIColor.white
        self.navigationBar.addSubview(self.titleLabel)
    }
    
    func setHamburger(_ stateValue: CGFloat) {
        self.hamburger.stateValue = stateValue
    }
    
    func setHamburger(_ state: HamburgerView.HamburgerState) {
        self.hamburger.state = state
    }
    
}
