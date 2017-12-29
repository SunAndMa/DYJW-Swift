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
    fileprivate let systemPanel = EduSystemPanel.loadFromNib()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupLoginPanel()
        self.setupSystemPanel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupLoginPanel() {
        self.loginPanel.delegate = self
        self.view.addSubview(self.loginPanel)
        self.loginPanel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(16)
            make.left.equalTo(self.view.snp.left).offset(16)
            make.right.equalTo(self.view.snp.right).offset(-16)
        }
    }
    
    fileprivate func setupSystemPanel() {
        self.systemPanel.alpha = 0
        self.systemPanel.isHidden = true
        self.view.addSubview(self.systemPanel)
        self.systemPanel.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginPanel.snp.bottom)
            make.left.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension EduSystemController: LoginPanelDelegate {
    
    func login(username: String, password: String, verifycode: String) {
        let user = User()
        user.username = username
        user.password = password
        EduSystemManager.shared.login(with: user, verifycode: verifycode) { (errorMessage) in
            let success = errorMessage == nil
            self.loginPanel.setLogin(success: success, errorMessage: errorMessage)
            if success {
                self.loginSuccess()
            }
        }
    }
    
    fileprivate func loginSuccess() {
        self.systemPanel.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.loginPanel.snp.updateConstraints { (make) in
                make.top.equalTo(self.view).offset(-1 * self.loginPanel.height)
            }
            self.loginPanel.alpha = 0
            self.systemPanel.alpha = 1
            self.view.layoutIfNeeded()
        }) { (finished) in
            if finished {
                self.loginPanel.isHidden = true
            }
        }
    }
    
    func loadVerifycode() {
        VerifyCode.loadVerifycodeImage { (verifycode) in
            guard let image = verifycode?.verifycodeImage else {
                self.loginPanel.loadVerifycodeFail()
                return
            }
            self.loginPanel.setVerifycode(image, recognizedCode: verifycode?.recognizedCode)
        }
    }
}
