//
//  NetworkTools.swift
//  Alamofire的使用
//
//  Created by 李锦萌 on 2019/4/17.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}


class NetworkTools {
    
    class func requestData(type : MethodType,URLString : String,parameters:[String : String]? = nil,finishedCallback:@escaping (_ result: Any)->()){
        
        // 1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error ?? 0)
                return
            }
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
}
