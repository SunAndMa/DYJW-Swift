//
//  MDNavigationDrawerController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/19.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

public protocol MDNavigationDrawerDelegate : NSObjectProtocol {
    func navigationDrawerStateValueChanged(stateValue: CGFloat)
    func navigationDrawerStateChanged(open: Bool)
}

class MDNavigationDrawerController: UIViewController, UIGestureRecognizerDelegate {
    
    private var drawer: UIView!
    private var controller: MDToolbarController!
    private var delegate: MDNavigationDrawerDelegate!
    private var drawerMask: UIView!
    var screenSize: CGSize = UIScreen.mainScreen().bounds.size
    private var drawerWidth = UIScreen.mainScreen().bounds.size.width * 2 / 3
    
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
        screenSize = UIScreen.mainScreen().bounds.size
        let drawerHeight = screenSize.height - controller.toolbarHeight
        drawerWidth = UIScreen.mainScreen().bounds.size.width * 2 / 3
        drawer.frame = CGRect(x: drawer.frame.origin.x == 0 ? 0 : -drawerWidth, y: controller.toolbarHeight, width: drawerWidth, height: drawerHeight)
        let shadowPath = UIBezierPath.init(rect: drawer.bounds)
        drawer.layer.shadowPath = shadowPath.CGPath;
        drawer.layer.mask!.frame = CGRect(x: -20, y: 0, width: drawerWidth + 40, height: drawerHeight + 20)
        drawerMask.frame = CGRect(x: 0, y: controller.toolbarHeight, width: screenSize.width, height: screenSize.height - controller.toolbarHeight)
    }
    
    private func addControllerView() {
        self.view.addSubview(controller.view)
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan))
        pan.delegate = self
        controller.view.addGestureRecognizer(pan)
    }
    
    private func createMask() {
        drawerMask = UIView.init(frame: CGRect(x: 0, y: controller.toolbarHeight, width: screenSize.width, height: screenSize.height - controller.toolbarHeight))
        drawerMask.backgroundColor = UIColor.grey900()
        drawerMask.alpha = 0
        drawerMask.hidden = true
        self.view.addSubview(drawerMask)
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan))
        drawer.addGestureRecognizer(pan)
    }
    
    private func addDrawer() {
        self.view.addSubview(drawer)
        let drawerHeight = screenSize.height - controller.toolbarHeight
        drawer.frame = CGRect(x: -drawerWidth, y: controller.toolbarHeight, width: drawerWidth, height: drawerHeight)
        drawer.layer.shadowColor = UIColor.grey900().CGColor;
        drawer.layer.shadowOffset = CGSize(width: 0, height: 0);
        drawer.layer.shadowOpacity = 0.0;
        let shadowPath = UIBezierPath.init(rect: drawer.bounds)
        drawer.layer.shadowPath = shadowPath.CGPath;
        let mask = CALayer.init()
        mask.backgroundColor = UIColor.whiteColor().CGColor
        mask.frame = CGRect(x: -20, y: 0, width: drawerWidth + 40, height: drawerHeight + 20)
        drawer.layer.mask = mask
        drawer.backgroundColor = UIColor.whiteColor()
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan))
        drawerMask.addGestureRecognizer(pan)
    }
    
    func openDrawer() {
        drawerMask.hidden = false
        UIView.animateWithDuration(0.3, animations: {
            var frame = self.drawer.frame
            frame.origin.x = 0
            self.drawer.frame = frame
            self.drawer.layer.shadowOpacity = 0.8
            self.drawerMask.alpha = 0.5
        })
    }
    
    func closeDrawer() {
        UIView.animateWithDuration(0.3, animations: {
            var frame = self.drawer.frame
            frame.origin.x = -frame.size.width
            self.drawer.frame = frame
            self.drawerMask.alpha = 0
            }, completion: { (finished: Bool) in
                self.drawerMask.hidden = true
                self.drawer.layer.shadowOpacity = 0
        })
    }
    
    private var panXOffset: CGFloat!
    func handlePan(pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizerState.Began {
            let location = pan.locationInView(controller.view)
            if pan.view == controller.view {
                if location.x < 30 {
                    drawer.layer.shadowOpacity = 0.8
                    panXOffset = location.x
                    drawerMask.hidden = false
                } else {
                    panXOffset = CGFloat.min
                }
            } else {
                panXOffset = location.x > drawerWidth ? 0 : location.x - drawerWidth
            }
        } else if pan.state == UIGestureRecognizerState.Changed {
            if panXOffset != CGFloat.min {
                var location = pan.locationInView(controller.view)
                location.x -= panXOffset
                var frame = drawer.frame
                var percent = location.x / frame.size.width
                percent = percent > 1 ? 1 : percent
                percent = percent < 0 ? 0 : percent
                var x = -frame.size.width * (1 - percent)
                x = x > 0 ? 0 : x
                frame.origin.x = x
                if percent == 1 && panXOffset < 0 {
                    panXOffset = pan.locationInView(controller.view).x - drawerWidth
                }
                if drawer.frame.origin.x < 0 && drawer.frame.origin.x > -drawerWidth {
                    delegate.navigationDrawerStateValueChanged(percent)
                }
                UIView.animateWithDuration(0.05, animations: {
                    self.drawer.frame = frame
                    self.drawerMask.alpha = percent / 2
                })
            }
        } else if pan.state == UIGestureRecognizerState.Ended {
            if panXOffset != CGFloat.min {
                let v = pan.velocityInView(controller.view)
                var frame = drawer.frame
                var location = pan.locationInView(controller.view)
                location.x -= panXOffset
                if v.x > 800 || v.x < -800 {
                    frame.origin.x = v.x > 0 ? 0 : -drawerWidth
                } else {
                    let percent = location.x / frame.size.width
                    frame.origin.x = percent >= 0.5 ? 0 : -drawerWidth
                }
                let duration = frame.origin.x == 0 ? (drawerWidth - location.x) / drawerWidth * 0.3 : location.x / drawerWidth * 0.3
                UIView.animateWithDuration(NSTimeInterval(duration), animations: {
                    self.drawer.frame = frame
                    self.drawerMask.alpha = frame.origin.x == 0 ? 0.5 : 0
                    }, completion: { (finished: Bool) in
                        self.drawer.layer.shadowOpacity = frame.origin.x == 0 ? 0.8 : 0;
                        self.drawerMask.hidden = frame.origin.x < 0
                })
                delegate.navigationDrawerStateChanged(frame.origin.x == 0 ? true : false)
            }
            panXOffset = CGFloat.min
        }
    }
    
    // MARK:- GestureRecognizer delegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return true
    }
}
