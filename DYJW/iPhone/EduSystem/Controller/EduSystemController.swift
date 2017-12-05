//
//  EduSystemController.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/5.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

class EduSystemController: FKBaseController {
    
    fileprivate let loginPanel = LoginPanel.loadFromNib()
    fileprivate var loginPanelTopConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        self.setupLoginPanel()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupLoginPanel() {
        self.view.addSubview(self.loginPanel)
        let topConstraint = NSLayoutConstraint(item: self.view,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.loginPanel,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: -16)
        let heightConstraint = NSLayoutConstraint(item: self.loginPanel,
                                               attribute: .height,
                                               relatedBy: .equal,
                                               toItem: nil,
                                               attribute: .height,
                                               multiplier: 1,
                                               constant: 284)
        let leftConstraint = NSLayoutConstraint(item: self.view,
                                                attribute: .leading,
                                                relatedBy: .equal,
                                                toItem: self.loginPanel,
                                                attribute: .leading,
                                                multiplier: 1,
                                                constant: -16)
        let rightConstraint = NSLayoutConstraint(item: self.view,
                                                 attribute: .trailing,
                                                 relatedBy: .equal,
                                                 toItem: self.loginPanel,
                                                 attribute: .trailing,
                                                 multiplier: 1,
                                                 constant: -16)
        self.loginPanelTopConstraint = topConstraint
        NSLayoutConstraint.activate([topConstraint, heightConstraint, leftConstraint, rightConstraint])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
