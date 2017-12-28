//
//  DrawerTabController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/19.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit
import SnapKit

protocol DrawerTabControllerDelegate: NSObjectProtocol {
    func navigationDrawerStateValueChanged(_ stateValue: CGFloat)
    func navigationDrawerStateChanged(_ open: Bool)
}

class DrawerTabController: UITabBarController {
    
    override var navigationController: BaseNavigationController? {
        get {
            return super.navigationController as? BaseNavigationController
        }
    }
    
    fileprivate let drawer = NavigationDrawer.loadFromNib()
    fileprivate weak var drawerDelegate: DrawerTabControllerDelegate?
    fileprivate var drawerMask: UIView!
    fileprivate var drawerWidth = UIScreen.main.bounds.size.width * 2 / 3

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addDrawerView()
    }
    
    fileprivate func addDrawerView() {
        let pan = UIPanGestureRecognizer(target: self.drawer, action: #selector(NavigationDrawer.dealPan(_:)))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        
        self.drawer.delegate = self
        self.view.addSubview(self.drawer)
        self.drawer.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
            make.top.equalTo(self.view).offset(navigationBarHeight + statusBarHeight)
            make.left.equalTo(self.view)
        }
    }
    
    func openDrawer() {
        self.drawer.openDrawer()
    }
    
    func closeDrawer() {
        self.drawer.closeDrawer()
    }
    
}

extension DrawerTabController: NavigationDrawerDelegate {
    
    func navigationDrawerWillShow() {
        self.drawer.snp.updateConstraints { (make) in
            make.left.equalTo(self.view)
        }
        self.view.layoutIfNeeded()
    }
    
    func navigationDrawerDidHide() {
        self.drawer.snp.updateConstraints { (make) in
            make.left.equalTo(self.view).offset(-self.view.bounds.width)
        }
        self.view.layoutIfNeeded()
    }
    
    func navigationDrawerDidChanged(_ stateValue: CGFloat) {
        self.navigationController?.setHamburger(stateValue)
    }
    
    func navigationDrawerDidChanged(state isOpen: Bool) {
        self.navigationController?.setHamburger(isOpen ? .back : .normal)
    }
    
    func navigationDrawerDidSelectItem(at index: Int) {
        self.selectedIndex = index
    }
}

extension DrawerTabController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            if pan.location(in: self.view).x <= 50 && pan.translation(in: self.view).x > 0 {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
