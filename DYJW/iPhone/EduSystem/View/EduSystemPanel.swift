//
//  EduSystemPanel.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/29.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

class EduSystemPanel: UIView {
    
    static func loadFromNib() -> EduSystemPanel {
        return Bundle.main.loadNibNamed("EduSystemPanel", owner: nil, options: nil)?.first as! EduSystemPanel
    }

}
