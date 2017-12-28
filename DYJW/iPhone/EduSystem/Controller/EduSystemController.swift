//
//  EduSystemController.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/5.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit
import SnapKit

class EduSystemController: FKBaseController {
    
    fileprivate let loginPanel = LoginPanel.loadFromNib()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupLoginPanel()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension EduSystemController: LoginPanelDelegate {
    
    func login(username: String, password: String, verifycode: String) {
        
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
