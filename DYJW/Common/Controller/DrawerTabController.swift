//
//  DrawerTabController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/19.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

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
    
    fileprivate var drawerLeadingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addDrawerView()
    }
    
    fileprivate func addDrawerView() {
        let pan = UIPanGestureRecognizer(target: self.drawer, action: #selector(NavigationDrawer.dealPan(_:)))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        
        self.drawer.delegate = self
        self.drawer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.drawer)
        let widthConstraint = NSLayoutConstraint(item: self.view,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: self.drawer,
                                                 attribute: .width,
                                                 multiplier: 1,
                                                 constant: 0)
        let heightConstraint = NSLayoutConstraint(item: self.view,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: self.drawer,
                                                  attribute: .height,
                                                  multiplier: 1,
                                                  constant: 0)
        let topConstraint = NSLayoutConstraint(item: self.view,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.drawer,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: -navigationBarHeight - statusBarHeight)
        let leftConstraint = NSLayoutConstraint(item: self.view,
                                                attribute: .leading,
                                                relatedBy: .equal,
                                                toItem: self.drawer,
                                                attribute: .leading,
                                                multiplier: 1,
                                                constant: 0)
        self.drawerLeadingConstraint = leftConstraint
        NSLayoutConstraint.activate([topConstraint, heightConstraint, leftConstraint, widthConstraint])
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
        self.drawerLeadingConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    func navigationDrawerDidHide() {
        self.drawerLeadingConstraint.constant = self.view.bounds.width
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
