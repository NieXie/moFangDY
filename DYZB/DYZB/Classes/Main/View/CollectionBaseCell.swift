//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/21.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

// 父类，相同的属性用于继承

import UIKit
import Kingfisher
class CollectionBaseCell: UICollectionViewCell {
     // MARK: 控件属性
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    // MARK:定义模型
    var anchor : AnchorModel?{
        didSet{
            // 0.校验模型是否有值
            guard let anchor = anchor else {return}
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr =  "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr =  "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            // 3.显示封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: ImageResource(downloadURL:iconURL))
        }
    }
}
