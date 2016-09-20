//
//  MDNavigationDrawer.swift
//  DYJW
//
//  Created by ingMeng on 16/9/19.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

class MDNavigationDrawer: UIView {
    
    private let padding: CGFloat = 8
    private let headerView: UIView = UIView.init()
    private let userLogo: UIImageView = UIImageView.init()
    private let usernameLabel: UILabel = UILabel.init()
    private let loginButton: UIButton = UIButton.init(type: UIButtonType.Custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headerView.backgroundColor = UIColor.lightBlue500()
        self.addSubview(headerView)
        self.setUserLogo()
        self.setUsernameLabel()
        self.setLoginButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUserLogo() {
        userLogo.layer.cornerRadius = 40
        userLogo.clipsToBounds = true
        self.addSubview(userLogo)
    }
    
    private func setUsernameLabel() {
        usernameLabel.textAlignment = NSTextAlignment.Center
        usernameLabel.textColor = UIColor.whiteColor()
        self.addSubview(usernameLabel)
    }
    
    private func setLoginButton() {
        loginButton.frame = CGRect(x: 0, y: 0, width: 86, height: 24)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.layer.cornerRadius = 6
        loginButton.clipsToBounds = true
        loginButton.setBackgroundImage(UIColor.pureColorImage(UIColor.lightBlue500(), size: CGSize(width: 86, height: 24)), forState: UIControlState.Normal)
        loginButton.setBackgroundImage(UIColor.pureColorImage(UIColor.lightBlue300(), size: CGSize(width: 86, height: 24)), forState: UIControlState.Highlighted)
        loginButton.addTarget(self, action: #selector(loginButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(loginButton)
        self.addSubview(loginButton)
    }
    
    override func layoutSubviews() {
        headerView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 80 + 18 + 24 + padding * 5)
        userLogo.frame = CGRect(x: self.frame.size.width / 2 - 40, y: padding * 1.5, width: 80, height: 80)
        usernameLabel.frame = CGRect(x: 0, y: 80 + padding * 2.5, width: self.frame.size.width, height: 18)
        loginButton.center = CGPoint(x: self.frame.size.width / 2, y: 80 + 18 + 12 + padding * 3.5)
    }
    
    func loginButtonClick() {
        
    }
}
