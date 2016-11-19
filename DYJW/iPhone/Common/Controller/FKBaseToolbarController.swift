//
//  FKBaseToolbarController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/20.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

class FKBaseToolbarController: MDToolbarController, MDNavigationDrawerDelegate {
    
    let hamburger: MDHamburgerView = MDHamburgerView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.addSubview(hamburger)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hamburgerClick))
        hamburger.addGestureRecognizer(tap)
    }

    func navigationDrawerStateValueChanged(stateValue: CGFloat) {
        hamburger.stateValue = stateValue
    }
    
    func navigationDrawerStateChanged(open: Bool) {
        hamburger.state = open ? MDHamburgerState.Back : MDHamburgerState.Normal
    }
    
    func hamburgerClick() {
        if hamburger.state == MDHamburgerState.Normal {
            hamburger.state = MDHamburgerState.Back;
            let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            app.openDrawer()
        } else {
            if (self.hamburger.state == MDHamburgerState.PopBack) {
                self.popViewControllerAnimated(true)
            }
            hamburger.state = MDHamburgerState.Normal;
            let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            app.closeDrawer()
        }
    }
}
