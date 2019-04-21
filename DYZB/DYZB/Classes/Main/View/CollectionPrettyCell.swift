//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/16.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

/// 颜值cell
class CollectionPrettyCell: CollectionBaseCell {
    
    // MARK: 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK: 定义属性
    override var anchor : AnchorModel?{
        // 监听属性的改变
        didSet{
            super.anchor = anchor
            // 2.显示所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
}
