//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/25.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

// CELL重用标识
private let gameViewCellID = "gameViewCellID"

class RecommendGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        // 注册CEll
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: gameViewCellID)
    }
}

// MARK:提供快速创建的类方法
extension RecommendGameView{
    //  MARK: 提供快速创建的类方法
    class func recommendGameView () ->RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

// MARK:-遵守collectionView的数据协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameViewCellID, for: indexPath)
        cell.backgroundColor =  indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
    }
    

}


