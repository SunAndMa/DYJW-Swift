//
//  LoginPanel.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/5.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

protocol LoginPanelDelegate: NSObjectProtocol {
    func login(username: String, password: String, verifycode: String)
    func loadVerifycode()
}

class LoginPanel: UIView {

    static func loadFromNib() -> LoginPanel {
        return Bundle.main.loadNibNamed("LoginPanel", owner: nil, options: nil)?.first as! LoginPanel
    }
    
    weak var delegate: LoginPanelDelegate? {
        didSet {
            self.loadVerifycode()
        }
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.errorMessageLabel.text = ""
        self.loadingVerifycodeView.isHidden = true
        self.loadingVerifycodeLabel.isHidden = true
        self.loginLoadingView.isHidden = true
    }
    
    func setVerifycode(_ image: UIImage, recognizedCode: String?) {
        self.verifycodeField.text = recognizedCode
        self.verifycodeImageView.image = image
        self.verifycodeImageView.isHidden = false
        self.loadingVerifycodeLabel.isHidden = true
        self.loadingVerifycodeView.isHidden = true
        self.loadingVerifycodeView.stopAnimating()
    }
    
    func loadVerifycodeFail() {
        self.verifycodeImageView.image = #imageLiteral(resourceName: "click_to_refresh")
        self.verifycodeImageView.isHidden = false
        self.loadingVerifycodeView.isHidden = true
        self.loadingVerifycodeView.stopAnimating()
        self.loadingVerifycodeLabel.isHidden = true
    }
    
    func setLogin(success: Bool, errorMessage: String?) {
        self.errorMessageLabel.text = errorMessage
        self.loginButton.isEnabled = true
        self.loginLoadingView.isHidden = true
        self.loginLoadingView.stopAnimating()
        if !success {
            self.loadVerifycode()
        }
    }
    
    @IBAction func verifycodeImageClicked(_ sender: Any) {
        self.loadVerifycode()
    }
    
    fileprivate func loadVerifycode() {
        self.verifycodeImageView.isHidden = true
        self.loadingVerifycodeView.isHidden = false
        self.loadingVerifycodeView.startAnimating()
        self.loadingVerifycodeLabel.isHidden = false
        self.delegate?.loadVerifycode()
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        guard let username = self.usernameField.text, username.length > 0 else {
            self.errorMessageLabel.text = "请输入用户名!"
            return
        }
        guard let password = self.passwordField.text, password.length > 0 else {
            self.errorMessageLabel.text = "请输入密码!"
            return
        }
        guard let verifycode = self.verifycodeField.text, verifycode.length > 0 else {
            self.errorMessageLabel.text = "请输入验证码!"
            return
        }
        self.errorMessageLabel.text = ""
        self.loginLoadingView.isHidden = false
        self.loginLoadingView.startAnimating()
        self.loginButton.isEnabled = false
        self.endEditing(true)
        self.delegate?.login(username: username, password: password, verifycode: verifycode)
    }
}
