//
//  FKBaseToolbarController.swift
//  DYJW
//
//  Created by ingMeng on 16/9/20.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

class FKBaseToolbarController: MDToolbarController, MDNavigationDrawerDelegate {
    
    let hamburger: MDHamburgerView = MDHamburgerView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.addSubview(hamburger)
    }

    func navigationDrawerStateValueChanged(stateValue: CGFloat) {
        hamburger.stateValue = stateValue
    }
    
    func navigationDrawerStateChanged(open: Bool) {
        hamburger.state = open ? MDHamburgerState.Back : MDHamburgerState.Normal
    }
}
