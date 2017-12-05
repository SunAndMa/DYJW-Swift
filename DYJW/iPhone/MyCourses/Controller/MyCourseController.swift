//
//  MyCourseController.swift
//  DYJW
//
//  Created by FlyKite on 16/9/21.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

class MyCourseController: FKBaseController {

    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet fileprivate weak var noCourseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
        self.loadData()
    }
    
    fileprivate func setupCollectionView() {
        let itemWidth = (Screen.width - 3) / 7
        let itemHeight = itemWidth * 2.5
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        self.flowLayout.itemSize = itemSize
        if isIphoneX {
            self.flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 34, right: 0)
        }
        self.collectionView.register(UINib(nibName: "CourseCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cell")
    }
    
    fileprivate func loadData() {
        self.collectionView.isHidden = true
        self.noCourseLabel.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MyCourseController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 * 7
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}
