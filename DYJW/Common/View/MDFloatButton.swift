//
//  MDFloatButton.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/29.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

class MDFloatButton: UIButton {
    
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
        
        self.backgroundColor = UIColor.lightBlue500
        
        self.createRippleView()
        
        self.layer.cornerRadius = 2
        self.layer.shadowColor = UIColor.grey900.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
    }
    
}
