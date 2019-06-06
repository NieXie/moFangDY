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
private let KEngeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK:定义数据的属性
    var groups : [AnchorGroup]?{
        didSet{
            // 移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            // 2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        // 注册CEll
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: gameViewCellID)
        // 给collectionView设置内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: KEngeInsetMargin, bottom: 0, right: KEngeInsetMargin)
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
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameViewCellID, for: indexPath)as!CollectionGameCell
        let group = groups![indexPath.item]
        cell.group = group
        return cell
    }
}


