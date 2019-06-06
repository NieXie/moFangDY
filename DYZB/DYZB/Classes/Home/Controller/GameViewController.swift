//
//  GameViewController.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/6/6.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

/// 边缘的间距
private let KEdgeMargin: CGFloat = 10
private let KItemW: CGFloat = (KSreenW - 2 * KEdgeMargin) / 3
private let KItemH: CGFloat = KItemW * 6 / 5
private let KGameCellID = "KGameCellID"

class GameViewController: UIViewController {

    // MARK：懒加载属性
    fileprivate lazy var collectionView:UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: KItemH)
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        // 边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: KEdgeMargin, bottom: 0, right: KEdgeMargin) 
        // 2.创建uicollectionView
        let collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
        collectionView.dataSource = self
        // 设置collectionView跟随父控件的大小进行展示
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collectionView
    }()
    
    
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}
// MARK:设置UI界面
extension GameViewController{
    
    fileprivate func setupUI(){
      view .addSubview(collectionView)
    }
}






// MARK:- 遵守UICollectionView的数据源和代理
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

