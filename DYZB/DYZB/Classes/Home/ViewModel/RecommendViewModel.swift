//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/17.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

class RecommendViewModel {
    // MARK:懒加载属性
    private lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

//MARK:发送网络请求
extension RecommendViewModel{
    func requestData()  {
        
        // 1.请求第一部分推荐数据
        
        // 2.请求第二部分颜值数据
        
        // 3.请求后面部分的游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1555566349
       
        NetworkTools.requestData(type: .GET, URLString:"http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]) { (result) in
            
            // 1.将result转成字典
            guard let resultDict = result as? [String : Any] else {return}
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String :Any]] else {return}
            
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            for group in self.anchorGroups {
                for anchors in group.anchors {
                    print(anchors.nickname)
                }
            }
        }
    }
}
