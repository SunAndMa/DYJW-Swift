//
//  NewsTabView.swift
//  DYJW
//
//  Created by FlyKite on 2017/12/6.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

protocol NewsTabViewDelegate: NSObjectProtocol {
    func tabDidSelect(at index: Int)
}

class NewsTabView: UIScrollView {
    
    weak var tabDelegate: NewsTabViewDelegate?
    var selectedIndex: Int = 0 {
        didSet {
            guard let lastLabel = self.viewWithTag(oldValue + 1) as? UILabel else {
                return
            }
            lastLabel.textColor = UIColor.lightBlue100
            
            guard let label = self.viewWithTag(self.selectedIndex + 1) as? UILabel else {
                return
            }
            label.textColor = UIColor.white
            
            var frame = self.underline.frame
            frame.size.width = label.frame.width
            frame.origin.x = label.frame.origin.x
            UIView.animate(withDuration: 0.4) {
                self.underline.frame = frame
                var offset = CGPoint(x: frame.origin.x - frame.size.width / 2, y: 0)
                offset.x = offset.x < self.contentSize.width - self.frame.size.width
                    ? offset.x
                    : self.contentSize.width - self.frame.size.width
                offset.x = offset.x > 0 ? offset.x : 0
                self.contentOffset = offset
            }
        }
    }
    
    
    fileprivate var underline: UIView!

    func createTabLabels(_ titles: [NewsListController.NewsSection]) {
        let subviews = self.subviews
        for view in subviews {
            view.removeFromSuperview()
        }
        var x: CGFloat = 0
        let y: CGFloat = 0
        for index in 0 ..< titles.count {
            let title = titles[index].title
            let bounds = title.boundingRect(with: CGSize(width: 999,
                                                         height: 999),
                                            options: .usesFontLeading,
                                            attributes: [.font: UIFont.systemFont(ofSize: 14)],
                                            context: nil)
            let width = bounds.width + 32
            let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: self.height))
            x += width
            label.text = title
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.lightBlue100
            label.textAlignment = .center
            label.tag = index + 1
            let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
            label.addGestureRecognizer(tap)
            label.isUserInteractionEnabled = true
            self.addSubview(label)
            if index == 0 {
                label.textColor = UIColor.white
                let line = UIView(frame: CGRect(x: 0, y: self.height - 3, width: width, height: 3))
                line.backgroundColor = UIColor.lightBlue100
                self.addSubview(line)
                self.underline = line
            }
        }
        var size = self.contentSize
        size.width = x
        self.contentSize = size
    }
    
    @objc fileprivate func tap(_ tap: UITapGestureRecognizer) {
        let tag = tap.view?.tag ?? 0
        self.selectedIndex = tag - 1
        self.tabDelegate?.tabDidSelect(at: tag)
    }

}
