//
//  FKBaseToolbarController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/20.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

class FKBaseToolbarController: MDToolbarController {
    
    let hamburger: HamburgerView = HamburgerView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.addSubview(hamburger)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hamburgerClick))
        hamburger.addGestureRecognizer(tap)
    }
    
    func hamburgerClick() {
        if hamburger.state == .normal {
            hamburger.state = .back;
            let app: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            app.openDrawer()
        } else {
            if (self.hamburger.state == .popBack) {
                self.popViewController(animated: true)
            }
            hamburger.state = .normal;
            let app: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            app.closeDrawer()
        }
    }
}

extension FKBaseToolbarController: MDNavigationDrawerDelegate {
    
    func navigationDrawerStateValueChanged(_ stateValue: CGFloat) {
        hamburger.stateValue = stateValue
    }
    
    func navigationDrawerStateChanged(_ open: Bool) {
        hamburger.state = open ? .back : .normal
    }
}
