//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/23.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {

    // MARK:控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK:定义模型属性
    var cycleModel : CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with:iconUrl)
        }
    }

}
