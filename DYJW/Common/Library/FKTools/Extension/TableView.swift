//
//  TableView.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/14.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        if Bundle.main.path(forResource: cellType.className, ofType: "nib") != nil {
            self.register(UINib(nibName: cellType.className, bundle: Bundle.main),
                          forCellReuseIdentifier: cellType.className)
        } else {
            self.register(cellType, forCellReuseIdentifier: cellType.className)
        }
    }
    
    
    
}
