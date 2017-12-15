//
//  Object.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/14.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

extension NSObject {
    
    static var className: String {
        get {
            return String(describing: self)
        }
    }
    
}
