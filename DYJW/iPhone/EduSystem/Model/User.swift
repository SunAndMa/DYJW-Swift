//
//  User.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/28.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit
import RealmSwift

class User: Object {
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var lastTime: Date = Date()
    @objc dynamic var lastSessionId: String = ""
}
