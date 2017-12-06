//
//  MDFlatButton.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/6.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

class MDFlatButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    fileprivate func setup() {
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        self.createRippleView()
    }

}
