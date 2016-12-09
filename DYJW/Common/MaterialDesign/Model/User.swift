//
//  User.swift
//  DYJW
//
//  Created by 国投 on 2016/12/8.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit
import CoreData

@objc(User)
class User: NSManagedObject {
    @NSManaged var username: String
    @NSManaged var password: String
    @NSManaged var name: String
    @NSManaged var last_time: Date
    @NSManaged var jsessionid: String
}
