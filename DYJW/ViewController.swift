//
//  ViewController.swift
//  DYJW
//
//  Created by 风筝 on 16/9/12.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button = UIButton.init(type: UIButtonType.Custom)
        button.frame = CGRectMake(100, 100, 100, 100)
        button.setTitle("按钮", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.lightBlue500()
        button.createRippleView()
        self.view.addSubview(button)
        
        let hamburger = MDHamburgerView.init()
        self.view.addSubview(hamburger)
        self.view.backgroundColor = UIColor.blackColor()
        hamburger.backgroundColor = UIColor.lightBlue500()
        hamburger.stateValue = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

