//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/12.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat ,g :CGFloat ,b : CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    // 扩充类方法，获取随机颜色
    class func randomColor() -> UIColor{
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
