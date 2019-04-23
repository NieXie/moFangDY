//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/23.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

// cell重用标识
private let cellID = "cellID"

class RecommendCycleView: UIView {
    // 定义属性
    var cycleModels : [CycleModel]?{
        didSet{
            // 1.刷新表格
            collectionView.reloadData()
            // 2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    // MARK:控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
     // 从xib里面加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        // 注册cell
       collectionView.register(UINib(nibName:"CollectionCycleCell" , bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    /// 在这里拿到的尺寸是正确的
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
    
}

// MARK ：提供一个快速创建的类方法

extension RecommendCycleView {
    
    class func recommendCycleView() -> RecommendCycleView {
        
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// MARK : 遵守UIcollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 如果可选类型没有值的话，返回0
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)as!CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item]
        return cell
    }
    
}

// MARK: 遵守UIcollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
        
    }
}
