//
//  CollectionViewNormalCell.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/15.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionBaseCell {

    // MARK:控件的属性
    @IBOutlet weak var roomNameLabel: UILabel!
    // MARK: 定义属性
    override var anchor : AnchorModel?{
        didSet{
            // 1.将属性传递给父类
            super.anchor = anchor
            // 2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }

}
