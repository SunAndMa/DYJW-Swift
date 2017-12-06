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

    @IBOutlet fileprivate weak var usernameField: MDTextField!
    @IBOutlet fileprivate weak var passwordField: MDTextField!
    @IBOutlet fileprivate weak var verifycodeField: MDTextField!
    @IBOutlet fileprivate weak var verifycodeImageView: UIImageView!
    @IBOutlet fileprivate weak var loadingVerifycodeView: MDProgressView!
    @IBOutlet fileprivate weak var loadingVerifycodeLabel: UILabel!
    @IBOutlet fileprivate weak var errorMessageLabel: UILabel!
    @IBOutlet fileprivate weak var loginLoadingView: MDProgressView!
    @IBOutlet fileprivate weak var loginButton: MDFlatButton!
    
}
