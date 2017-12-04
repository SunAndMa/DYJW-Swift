//
//  DrawerCell.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/4.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

class DrawerCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(title: String, icon: UIImage) {
        self.titleLabel.text = title
        self.iconImageView.image = icon
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
