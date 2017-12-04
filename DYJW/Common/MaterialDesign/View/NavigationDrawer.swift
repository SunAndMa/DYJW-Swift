//
//  MDNavigationDrawer.swift
//  DYJW
//
//  Created by FlyKite on 16/9/19.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit
import CoreData

class NavigationDrawer: UIView {
    
    fileprivate let padding: CGFloat = 8
    fileprivate let headerView: UIView = UIView.init()
    fileprivate let userLogo: UIImageView = UIImageView.init()
    fileprivate let usernameLabel: UILabel = UILabel.init()
    fileprivate let loginButton: UIButton = UIButton.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headerView.backgroundColor = UIColor.lightBlue500
        self.addSubview(headerView)
        self.setUserLogo()
        self.setUsernameLabel()
        self.setLoginButton()
        self.setUserInfo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setUserLogo() {
        userLogo.layer.cornerRadius = 40
        userLogo.clipsToBounds = true
        self.addSubview(userLogo)
    }
    
    fileprivate func setUsernameLabel() {
        usernameLabel.textAlignment = NSTextAlignment.center
        usernameLabel.textColor = UIColor.white
        self.addSubview(usernameLabel)
    }
    
    fileprivate func setLoginButton() {
        loginButton.frame = CGRect(x: 0, y: 0, width: 86, height: 24)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = 6
        loginButton.clipsToBounds = true
        let normalImage = UIImage.createImage(with: UIColor.lightBlue500, size: CGSize(width: 86, height: 24))
        let highlightedImage = UIImage.createImage(with: UIColor.lightBlue300, size: CGSize(width: 86, height: 24))
        loginButton.setBackgroundImage(normalImage, for: .normal)
        loginButton.setBackgroundImage(highlightedImage, for: .highlighted)
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: UIControlEvents.touchUpInside)
        headerView.addSubview(loginButton)
        self.addSubview(loginButton)
    }
    
    private func setUserInfo() {
        let uu = ModelUtil.query(User.self)?.first
        print("123456".md5Value)
        if let user = uu {
            userLogo.image = UIImage(named: "default_user")
            usernameLabel.text = user.name
            loginButton.setTitle("注销", for: UIControlState.normal)
        } else {
            userLogo.image = UIImage(named: "default_user")
            usernameLabel.text = "请登录教务管理系统"
            loginButton.setTitle("登录", for: UIControlState.normal)
            let _ = ModelUtil.insert({ (user: User) in
                user.name = "风筝"
                user.username = "1234567489"
                user.password = "44564564"
            })
        }
    }
    
    override func layoutSubviews() {
        headerView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 80 + 18 + 24 + padding * 5)
        userLogo.frame = CGRect(x: self.frame.size.width / 2 - 40, y: padding * 1.5, width: 80, height: 80)
        usernameLabel.frame = CGRect(x: 0, y: 80 + padding * 2.5, width: self.frame.size.width, height: 18)
        loginButton.center = CGPoint(x: self.frame.size.width / 2, y: 80 + 18 + 12 + padding * 3.5)
    }
    
    @objc fileprivate func loginButtonClick() {
        
    }
}
