//
//  LoginPanel.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/5.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

class LoginPanel: UIView {

    static func loadFromNib() -> LoginPanel {
        return Bundle.main.loadNibNamed("LoginPanel", owner: nil, options: nil)?.first as! LoginPanel
    }

}
