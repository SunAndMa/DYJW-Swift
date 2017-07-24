//
//  MDNavigationDrawerController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/19.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

public protocol MDNavigationDrawerDelegate: class {
    func navigationDrawerStateValueChanged(_ stateValue: CGFloat)
    func navigationDrawerStateChanged(_ open: Bool)
}

class MDNavigationDrawerController: UIViewController, UIGestureRecognizerDelegate {
    
    fileprivate var drawer: UIView!
    fileprivate var controller: MDToolbarController!
    fileprivate weak var delegate: MDNavigationDrawerDelegate?
    fileprivate var drawerMask: UIView!
    var screenSize: CGSize = UIScreen.main.bounds.size
    fileprivate var drawerWidth = UIScreen.main.bounds.size.width * 2 / 3
    
    init(drawerView: UIView, toolbarController: MDToolbarController, navigationDrawerDelegate: MDNavigationDrawerDelegate) {
        super.init(nibName: nil, bundle: nil)
        drawer = drawerView
        controller = toolbarController
        delegate = navigationDrawerDelegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK:
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addControllerView()
        self.createMask()
        self.addDrawer()
    }
    
    override func viewWillLayoutSubviews() {
        screenSize = UIScreen.main.bounds.size
        let drawerHeight = screenSize.height - controller.toolbarHeight
        drawerWidth = UIScreen.main.bounds.size.width * 2 / 3
        drawer.frame = CGRect(x: drawer.frame.origin.x == 0 ? 0 : -drawerWidth, y: controller.toolbarHeight, width: drawerWidth, height: drawerHeight)
        let shadowPath = UIBezierPath.init(rect: drawer.bounds)
        drawer.layer.shadowPath = shadowPath.cgPath;
        drawer.layer.mask!.frame = CGRect(x: -20, y: 0, width: drawerWidth + 40, height: drawerHeight + 20)
        drawerMask.frame = CGRect(x: 0, y: controller.toolbarHeight, width: screenSize.width, height: screenSize.height - controller.toolbarHeight)
    }
    
    fileprivate func addControllerView() {
        self.view.addSubview(controller.view)
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan))
        pan.delegate = self
        controller.view.addGestureRecognizer(pan)
    }
    
    fileprivate func createMask() {
        drawerMask = UIView.init(frame: CGRect(x: 0, y: controller.toolbarHeight, width: screenSize.width, height: screenSize.height - controller.toolbarHeight))
        drawerMask.backgroundColor = UIColor.grey900
        drawerMask.alpha = 0
        drawerMask.isHidden = true
        self.view.addSubview(drawerMask)
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan))
        drawer.addGestureRecognizer(pan)
    }
    
    fileprivate func addDrawer() {
        self.view.addSubview(drawer)
        let drawerHeight = screenSize.height - controller.toolbarHeight
        drawer.frame = CGRect(x: -drawerWidth, y: controller.toolbarHeight, width: drawerWidth, height: drawerHeight)
        drawer.layer.shadowColor = UIColor.grey900.cgColor;
        drawer.layer.shadowOffset = CGSize(width: 0, height: 0);
        drawer.layer.shadowOpacity = 0.0;
        let shadowPath = UIBezierPath.init(rect: drawer.bounds)
        drawer.layer.shadowPath = shadowPath.cgPath;
        let mask = CALayer.init()
        mask.backgroundColor = UIColor.white.cgColor
        mask.frame = CGRect(x: -20, y: 0, width: drawerWidth + 40, height: drawerHeight + 20)
        drawer.layer.mask = mask
        drawer.backgroundColor = UIColor.white
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan))
        drawerMask.addGestureRecognizer(pan)
    }
    
    func openDrawer() {
        drawerMask.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            var frame = self.drawer.frame
            frame.origin.x = 0
            self.drawer.frame = frame
            self.drawer.layer.shadowOpacity = 0.8
            self.drawerMask.alpha = 0.5
        })
    }
    
    func closeDrawer() {
        UIView.animate(withDuration: 0.3, animations: {
            var frame = self.drawer.frame
            frame.origin.x = -frame.size.width
            self.drawer.frame = frame
            self.drawerMask.alpha = 0
            }, completion: { (finished: Bool) in
                self.drawerMask.isHidden = true
                self.drawer.layer.shadowOpacity = 0
        })
    }
    
    fileprivate var panXOffset: CGFloat!
    func handlePan(_ pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizerState.began {
            let location = pan.location(in: controller.view)
            if pan.view == controller.view {
                if location.x < 30 {
                    drawer.layer.shadowOpacity = 0.8
                    panXOffset = location.x
                    drawerMask.isHidden = false
                } else {
                    panXOffset = CGFloat.leastNormalMagnitude
                }
            } else {
                panXOffset = location.x > drawerWidth ? 0 : location.x - drawerWidth
            }
        } else if pan.state == UIGestureRecognizerState.changed {
            if panXOffset != CGFloat.leastNormalMagnitude {
                var location = pan.location(in: controller.view)
                location.x -= panXOffset
                var frame = drawer.frame
                var percent = location.x / frame.size.width
                percent = percent > 1 ? 1 : percent
                percent = percent < 0 ? 0 : percent
                var x = -frame.size.width * (1 - percent)
                x = x > 0 ? 0 : x
                frame.origin.x = x
                if percent == 1 && panXOffset < 0 {
                    panXOffset = pan.location(in: controller.view).x - drawerWidth
                }
                if drawer.frame.origin.x < 0 && drawer.frame.origin.x > -drawerWidth {
                    delegate?.navigationDrawerStateValueChanged(percent)
                }
                UIView.animate(withDuration: 0.05, animations: {
                    self.drawer.frame = frame
                    self.drawerMask.alpha = percent / 2
                })
            }
        } else if pan.state == UIGestureRecognizerState.ended {
            if panXOffset != CGFloat.leastNormalMagnitude {
                let v = pan.velocity(in: controller.view)
                var frame = drawer.frame
                var location = pan.location(in: controller.view)
                location.x -= panXOffset
                if v.x > 800 || v.x < -800 {
                    frame.origin.x = v.x > 0 ? 0 : -drawerWidth
                } else {
                    let percent = location.x / frame.size.width
                    frame.origin.x = percent >= 0.5 ? 0 : -drawerWidth
                }
                let duration = frame.origin.x == 0 ? (drawerWidth - location.x) / drawerWidth * 0.3 : location.x / drawerWidth * 0.3
                UIView.animate(withDuration: TimeInterval(duration), animations: {
                    self.drawer.frame = frame
                    self.drawerMask.alpha = frame.origin.x == 0 ? 0.5 : 0
                    }, completion: { (finished: Bool) in
                        self.drawer.layer.shadowOpacity = frame.origin.x == 0 ? 0.8 : 0;
                        self.drawerMask.isHidden = frame.origin.x < 0
                })
                delegate?.navigationDrawerStateChanged(frame.origin.x == 0 ? true : false)
            }
            panXOffset = CGFloat.leastNormalMagnitude
        }
    }
    
    // MARK:- GestureRecognizer delegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
