//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/18.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    /// 该组中对应的房间信息
    @objc var room_list : [[String : NSObject]]? {
        /// 监听属性的改变
        didSet {
            guard let room_list = room_list else {return}
            for dict  in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    /// 组显示的标题
   @objc var tag_name: String = ""
    /// 组显示的图标
   @objc var icon_name : String = "home_header_normal"
    
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
