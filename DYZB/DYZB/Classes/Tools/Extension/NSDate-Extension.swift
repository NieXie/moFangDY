//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/17.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import Foundation

extension NSDate{
    // 获取当前的时间
    class func getCurrentTime() ->String {
        let nowData = NSDate()
        let interval = Int(nowData.timeIntervalSince1970) 
        return "\(interval)"
    }
}
