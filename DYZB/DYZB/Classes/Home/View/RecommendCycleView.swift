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
    // 定时器
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]?{
        didSet{
            // 1.刷新表格
            collectionView.reloadData()
            // 2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            // 3.默认滚动到中间某一个位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            // 4.添加定时器
            // 先移除，在添加
            removeCycleTimer()
            addCycleTimer()
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
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)as!CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
    
}

// MARK: 遵守UIcollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate{
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    
    // 将要拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 移除定时器
        removeCycleTimer()
    }
    // 结束拖拽
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // 添加定时器
        addCycleTimer()
    }
}

// MARK: 对定时器的操作方法
extension RecommendCycleView {
    // 创建定时器的方法
    private func addCycleTimer(){
        // 创建定时器
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        // 将定时器添加到循环中
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    // 移除定时器的方法
    private func removeCycleTimer(){
        // 从运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext(){
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
