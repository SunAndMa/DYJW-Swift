//
//  NewsListController.swift
//  DYJW
//
//  Created by FlyKite on 2017/12/6.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

class NewsListController: FKBaseController {
    
    @IBInspectable
    var type: String? {
        didSet {
            self.setSections()
        }
    }
    
    typealias NewsSection = (title: String, urlSuffix: String)
    
    fileprivate let newsType = "News"
    fileprivate let noticeType = "Notice"
    
    fileprivate var newsSections: [NewsSection] = []

    @IBOutlet weak var tabView: NewsTabView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabView.tabDelegate = self
        self.tabView.createTabLabels(self.newsSections)
        
        self.collectionView.register(NewsListViewCell.self)
        
    }
    
    fileprivate func setSections() {
        if self.type == newsType {
            self.newsSections = [
                ("通知公告", "520203.html"),
                ("东油要闻", "520202.html"),
                ("教学科研", "520205.html"),
                ("党建思政", "520204.html"),
                ("菁菁校园", "520208.html"),
                ("院部动态", "520209.html"),
                ("交流合作", "520215.html"),
                ("媒体聚焦", "520210.html"),
                ("典型宣传", "520206.html"),
                ("专题热点", "520211.html"),
                ("高教视点", "520218.html"),
                ("理论学习", "520219.html"),
                ("创意东油", "520222.html")
            ]
        } else {
            self.newsSections = [
                ("通知公告", "350312.html"),
                ("新闻动态", "350309.html"),
                ("机构设置", "350302.html"),
                ("办事指南", "350304.html"),
                ("规章制度", "350303.html"),
                ("教学建设", "350316.html"),
                ("资料下载", "350305.html"),
                ("信息发布", "350307.html"),
                ("高教视窗", "350317.html")
            ]
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = self.collectionView.bounds.size
        }
    }

}

extension NewsListController: NewsTabViewDelegate {
    
    func tabDidSelect(at index: Int) {
        
    }
}

extension NewsListController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsSections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(NewsListViewCell.self, for: indexPath)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.tabView.selectedIndex = index
    }
}
