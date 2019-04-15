//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/15.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

// 间距
private let KItemMargin : CGFloat = 10
// 宽度
private let KItemW = (KSreenW - 3 * KItemMargin) / 2
// 高度
private let KItemH = KSreenW * 3 / 4
// 组头高度
private let KHeaderViewH : CGFloat = 50
// 普通cellID
private let KNormalCellID = "KNormalCellID"
// 组头重用标识
private let KHeaderViewID = "KHeaderViewID"
class RecommendViewController: UIViewController {
    
    // MARK:    懒加载属性
    private lazy var collectionView : UICollectionView = { [unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        // 尺寸的大小
        layout.itemSize = CGSize(width: KItemW, height: KItemH)
        // 行间距，列间距
        layout.minimumLineSpacing = 0
        // 最小间距
        layout.minimumInteritemSpacing = KItemMargin
        // 组头
        layout.headerReferenceSize = CGSize(width: KSreenW, height: KHeaderViewH)
        // 设置内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right:KItemMargin )
        // 2.创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.blue
        collectionView.dataSource = self
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KNormalCellID)
        // 注册组头
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
        // 设置collectionView跟随父控件的大小进行展示
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK:设置UI界面
extension RecommendViewController{
    private func setupUI(){
        // 1.将UICollectionView添加到视图的View中
        view.addSubview(collectionView)
    }
}


// MARK:遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource {
    // 有几组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    // 每组有几个
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 8
        }
        return 4
    }
    // 显示什么样的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    // 组头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.去除Seation的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath)
        headerView.backgroundColor = UIColor.green
        return headerView
    }
}





