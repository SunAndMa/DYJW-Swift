//
//  MDNavigationDrawerController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/19.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

class MDNavigationDrawerController: UIViewController, UIGestureRecognizerDelegate {
    
    private var drawer: MDNavigationDrawer!
    private var controller: MDToolbarController!
    private var drawerMask: UIView!
    let screenSize: CGSize = UIScreen.mainScreen().bounds.size
    private let drawerWidth = UIScreen.mainScreen().bounds.size.width * 2 / 3
    
    init(drawerView: MDNavigationDrawer, toolbarController: MDToolbarController) {
        super.init(nibName: nil, bundle: nil)
        drawer = drawerView
        controller = toolbarController
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
    
    private func addControllerView() {
        self.view.addSubview(controller.view)
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan))
        pan.delegate = self
        controller.view.addGestureRecognizer(pan)
    }
    
    private func createMask() {
        drawerMask = UIView.init(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        drawerMask.backgroundColor = UIColor.grey900()
        drawerMask.alpha = 0
        drawerMask.hidden = true
        self.view.addSubview(drawerMask)
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
    }
    
    private var panXOffset: CGFloat!
    func handlePan(pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizerState.Began {
            let location = pan.locationInView(controller.view)
            if location.x < 30 {
                drawer.layer.shadowOpacity = 0.8;
                panXOffset = location.x
                drawerMask.hidden = false
            } else {
                panXOffset = -1
            }
        } else if pan.state == UIGestureRecognizerState.Changed {
            if panXOffset >= 0 {
                var location = pan.locationInView(controller.view)
                location.x -= panXOffset
                var frame = drawer.frame
                var percent = location.x / frame.size.width
                percent = percent > 1 ? 1 : percent
                percent = percent < 0 ? 0 : percent
                var x = -frame.size.width * (1 - percent)
                x = x > 0 ? 0 : x
                frame.origin.x = x
                drawer.frame = frame
                drawerMask.alpha = percent / 2
            }
        } else if pan.state == UIGestureRecognizerState.Ended {
            if panXOffset >= 0 {
                
            }
            panXOffset = -1
        }
    }
    
    // MARK:- GestureRecognizer delegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return true
    }
}
