//
//  MDNavigationDrawer.swift
//  DYJW
//
//  Created by FlyKite on 16/9/19.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit
import CoreData

protocol NavigationDrawerDelegate: NSObjectProtocol {
    func navigationDrawerWillShow()
    func navigationDrawerDidHide()
    func navigationDrawerDidChanged(_ stateValue: CGFloat)
    func navigationDrawerDidChanged(state isOpen: Bool)
    func navigationDrawerDidSelectItem(at index: Int)
}

class NavigationDrawer: UIView {
    
    static func loadFromNib() -> NavigationDrawer {
        return Bundle.main.loadNibNamed("NavigationDrawer", owner: nil, options: nil)?.first as! NavigationDrawer
    }
    
    weak var delegate: NavigationDrawerDelegate?
    
    @IBOutlet fileprivate weak var contentView: UIView!
    @IBOutlet fileprivate weak var contentViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var userImageView: UIImageView!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var loginButton: UIButton!
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate typealias DrawerItem = (title: String, icon: UIImage)
    fileprivate let items: [DrawerItem] = [
        DrawerItem(title: "我的课表", icon: #imageLiteral(resourceName: "course_blue")),
//        DrawerItem(title: "黎明湖畔", icon: #imageLiteral(resourceName: "market_blue")),
        DrawerItem(title: "教务系统", icon: #imageLiteral(resourceName: "jiaowu_blue")),
        DrawerItem(title: "东油新闻", icon: #imageLiteral(resourceName: "news_blue")),
        DrawerItem(title: "教务通知", icon: #imageLiteral(resourceName: "notice_blue"))
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tableView.register(UINib(nibName: "DrawerCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        self.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        
        self.setDrawerViewHidden(true)
        self.setLoginButton()
        self.setUserInfo()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dealTap(_:)))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dealPan(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
    }
    
    func openDrawer() {
        self.delegate?.navigationDrawerWillShow()
        self.startAnimation(false, animationDuration: 0.25)
    }
    
    func closeDrawer() {
        self.startAnimation(true, animationDuration: 0.25)
    }
    
    fileprivate func setLoginButton() {
        let normalImage = UIImage.createImage(with: UIColor.lightBlue500, size: CGSize(width: 86, height: 24))
        let highlightedImage = UIImage.createImage(with: UIColor.lightBlue300, size: CGSize(width: 86, height: 24))
        self.loginButton.setBackgroundImage(normalImage, for: .normal)
        self.loginButton.setBackgroundImage(highlightedImage, for: .highlighted)
        self.loginButton.layer.borderUIColor = UIColor.white
    }
    
    private func setUserInfo() {
        let uu = ModelUtil.query(User.self)?.first
        if let user = uu {
            self.userImageView.image = #imageLiteral(resourceName: "default_user")
            self.usernameLabel.text = user.name
            self.loginButton.setTitle("注销", for: UIControlState.normal)
        } else {
            self.userImageView.image = #imageLiteral(resourceName: "default_user")
            self.usernameLabel.text = "请登录教务管理系统"
            self.loginButton.setTitle("登录", for: UIControlState.normal)
            let _ = ModelUtil.insert({ (user: User) in
                user.name = "风筝"
                user.username = "1234567489"
                user.password = "44564564"
            })
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        
    }
    
    fileprivate var startLocation = CGPoint.zero
    fileprivate var showing = false
    @objc func dealPan(_ pan: UIPanGestureRecognizer) {
        if pan.state == .began {
            self.delegate?.navigationDrawerWillShow()
            self.startLocation = pan.location(in: self)
            self.showing = self.contentViewLeadingConstraint.constant != 0
        } else if pan.state == .changed {
            let location = pan.location(in: self)
            let startX = self.startLocation.x <= self.contentView.bounds.width
                ? startLocation.x
                : self.contentView.bounds.width
            var constant = location.x - startX
            if self.showing {
                constant -= self.contentView.bounds.width
            }
            constant = constant > 0 ? 0 : constant
            self.contentViewLeadingConstraint.constant = constant
            self.layoutIfNeeded()
            let alpha = 0.5 + 0.5 * constant / self.contentView.bounds.width
            self.backgroundColor = UIColor(white: 0, alpha: alpha)
            var percent = 1 + constant / self.contentView.bounds.width
            percent = percent > 1 ? 1 : percent
            percent = percent < 0 ? 0 : percent
            self.delegate?.navigationDrawerDidChanged(percent)
        } else if pan.state == .ended || pan.state == .cancelled || pan.state == .failed {
            let velocity = pan.velocity(in: self)
            var percent = -self.contentViewLeadingConstraint.constant / self.contentView.bounds.width
            percent = percent < 0 ? 0 : percent
            if velocity.x < -800 {
                self.setDrawerViewHidden(true, animationDuration: 0.25 * (1 - percent))
            } else if velocity.x > 800 {
                self.setDrawerViewHidden(false, animationDuration: 0.25 * percent)
            } else {
                if percent >= 0.5 {
                    self.setDrawerViewHidden(true, animationDuration: 0.25 * (1 - percent))
                } else {
                    self.setDrawerViewHidden(false, animationDuration: 0.25 * percent)
                }
            }
        }
    }
    
    @objc fileprivate func dealTap(_ tap: UITapGestureRecognizer) {
        self.setDrawerViewHidden(true, animationDuration: 0.25)
    }
    
    fileprivate func setDrawerViewHidden(_ isHidden: Bool, animationDuration: CGFloat = 0, delay: TimeInterval = 0) {
        self.delegate?.navigationDrawerDidChanged(state: !isHidden)
        self.startAnimation(isHidden, animationDuration: animationDuration, delay: delay)
    }
    
    fileprivate func startAnimation(_ isHidden: Bool, animationDuration: CGFloat = 0, delay: TimeInterval = 0) {
        UIView.animate(withDuration: TimeInterval(animationDuration), delay: delay, options: .curveEaseInOut, animations: {
            self.contentViewLeadingConstraint.constant = (isHidden ? -self.contentView.bounds.width : 0)
            self.backgroundColor = UIColor(white: 0, alpha: isHidden ? 0 : 0.5)
            self.layoutIfNeeded()
        }) { (finished) in
            if isHidden {
                self.delegate?.navigationDrawerDidHide()
            }
        }
    }
    
}

extension NavigationDrawer: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DrawerCell
        let item = self.items[indexPath.row]
        cell.set(title: item.title, icon: item.icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(didSelectedRow(_:)), userInfo: indexPath.row, repeats: false)
    }
    
    @objc fileprivate func didSelectedRow(_ timer: Timer) {
        if let index = timer.userInfo as? Int {
            self.setDrawerViewHidden(true, animationDuration: 0.25)
            self.delegate?.navigationDrawerDidSelectItem(at: index)
        }
    }
}

extension NavigationDrawer: UIGestureRecognizerDelegate {
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            return pan.translation(in: self).x < 0
        } else if let tap = gestureRecognizer as? UITapGestureRecognizer {
            let location = tap.location(in: self)
            return !self.contentView.frame.contains(location)
        }
        return true
    }
}
