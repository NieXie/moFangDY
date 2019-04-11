//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/11.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    // 便利构造函数
    // 在构造函数中必须明确调用一个设计函数(self)
    // 加上默认参数
    convenience init(imageName : String ,highImageName : String = "" , size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != ""{
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init (customView : btn)
    }
}
