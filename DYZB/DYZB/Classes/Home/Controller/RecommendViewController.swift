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
// 默认高度
private let KNormalItemH = KItemW * 3 / 4
// 颜值高度
private let KPrettyItemH = KItemW * 4 / 3
// 组头高度
private let KHeaderViewH : CGFloat = 50
// 普通cellID
private let KNormalCellID = "KNormalCellID"
// 颜值cellID
private let KPrettyCellID = "KPrettyCellID"
// 组头重用标识
private let KHeaderViewID = "KHeaderViewID"
class RecommendViewController: UIViewController {
    
    // MARK:    懒加载属性
    private lazy var collectionView : UICollectionView = { [unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        // 尺寸的大小
        layout.itemSize = CGSize(width: KItemW, height: KNormalItemH)
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
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        // 注册cell  CollectionViewNormalCell       CollectionPrettyCell
        collectionView.register( UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCellID)
        collectionView.register( UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: KPrettyCellID)
        // 注册组头
        collectionView.register( UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
        // 设置collectionView跟随父控件的大小进行展示
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        return collectionView
    }()
    
    // 定义ViewModel属性
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    
    
    
    // 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        setupUI()
        // 发送网络请求
        loadData()
    }
}

// MARK:设置UI界面
extension RecommendViewController{
    private func setupUI(){
        // 1.将UICollectionView添加到视图的View中
        view.addSubview(collectionView)
    }
}

// MARK:请求数据
extension RecommendViewController{
    private func loadData(){
        recommendVM.requestData()
    }
}

// MARK:遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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
        // 1 定义cell
        var cell : UICollectionViewCell!
        // 2 取出cell
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCellID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)
        }
        return cell
    }
    // 组头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出Seation的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath)
        return headerView
    }
    
    // 格子尺寸的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: KItemW, height: KPrettyItemH)
        }
        return CGSize(width: KItemW, height: KNormalItemH)
    }
}





