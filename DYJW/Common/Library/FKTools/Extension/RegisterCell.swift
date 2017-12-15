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
    
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        if let cell = self.dequeueReusableCell(withIdentifier: cellType.className, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Dequeue cell failed at (row: \(indexPath.item), section: \(indexPath.section))")
        }
    }
    
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        if Bundle.main.path(forResource: cellType.className, ofType: "nib") != nil {
            self.register(UINib(nibName: cellType.className, bundle: Bundle.main),
                          forCellWithReuseIdentifier: cellType.className)
        } else {
            self.register(cellType, forCellWithReuseIdentifier: cellType.className)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        if let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.className, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Dequeue cell failed at (item: \(indexPath.item), section: \(indexPath.section))")
        }
    }
    
}
