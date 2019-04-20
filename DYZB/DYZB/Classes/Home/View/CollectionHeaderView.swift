//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/15.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    //MARK:控件属性
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
