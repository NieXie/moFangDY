//
//  CycleModel.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/23.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 标题
    @objc var title : String = ""
    // 展示的图片地址
    @objc var pic_url : String = ""
    // 主播信息对应的字典
    @objc var room : [String : Any]?{
        didSet{
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    // 主播信息对应的模型对象
    var anchor : AnchorModel?
    
    // MARK:自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
