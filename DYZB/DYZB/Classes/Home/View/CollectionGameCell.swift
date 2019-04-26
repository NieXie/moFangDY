//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/26.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionGameCell: UICollectionViewCell {

   
    // MARK:控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:定义模型属性
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            let url = URL(string: group?.icon_url ?? "")
            iconImageView.kf.setImage(with: url,placeholder: UIImage(named:"home_more_btn"))
        }
    }
    
}
