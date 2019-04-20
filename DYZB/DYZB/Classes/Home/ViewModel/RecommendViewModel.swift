//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/17.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

/*
 1.请求第0组和一组的数据并转成模型对象
 2.对数据进行排序
 3.显示headerView中的内容
 */


class RecommendViewModel {
    // MARK:懒加载属性
    // 2-12组数据
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    // 接收下面的成员变量属性
    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

//MARK:发送网络请求
extension RecommendViewModel{
    func requestData(finishCallback: @escaping ()->())  {
        // 1.定义参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        // 2.创建group，发送网络请求时进入组，获取到数据后离开组
        let dGroup = DispatchGroup()
        // 3.请求第一部分推荐数据
        // 发请求时添加进组
        dGroup.enter()
        // "http://capi.douyucdn.cn/api/v1/getbigDataRoom"
        NetworkTools.requestData(type: .GET, URLString:"http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters:["time":NSDate.getCurrentTime()]) { (result) in
            // 1.将result转成字典
            guard let resultDict = result as? [String : Any] else {return}
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String :Any]] else {return}
            // 3.遍历字典转成模型对象
            // 3.1设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            // 3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            // 3.3 离开组
            dGroup.leave()
        }
        
        // 2.请求第二部分颜值数据
        // "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
        // 发请求时添加进组
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString:"http://capi.douyucdn.cn/api/v1/getVerticalRoom" , parameters: parameters) { (result) in
            // 1.将result转成字典
            guard let resultDict = result as? [String : Any] else {return}
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String :Any]] else {return}
            // 3.遍历字典转成模型对象
            // 3.1设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            // 3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            // 3.3 离开组
            dGroup.leave()
        }
        
        // 3.请求2-12部分的游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1555566349
        // 发请求时添加进组
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString:"http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            // 1.将result转成字典
            guard let resultDict = result as? [String : Any] else {return}
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String :Any]] else {return}
            
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            // 3.4 离开组
            dGroup.leave()
        }
        // 6.所有的数据请求到，之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
} 
