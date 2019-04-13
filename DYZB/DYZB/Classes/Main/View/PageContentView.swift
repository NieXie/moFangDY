//
//  PageContentView.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/12.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

// 定义协议
protocol PageContentViewDelegate : class {
    // 协议方法
    func pageContentView(pageContentView : PageContentView ,progess : CGFloat ,sourceIndex : Int ,targetIndex : Int)
    
}

// cell 标识
private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    // 属性接收传递过来的值
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    
    // 用来保存偏移量的属性
    private var startOffsetX : CGFloat = 0
    
    // 定义协议的属性
    weak var delegate : PageContentViewDelegate?
    
    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView =  { [weak self] in
       // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    // MARK:- 自定义构造函数
    init(frame : CGRect , childVcs : [UIViewController] , parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK : -设置UI界面
extension PageContentView {
    private func setupUI(){
        // 1.将所有的子控制添加到父控制器中
        for chidVc in childVcs {
            parentViewController?.addChild(chidVc)
        }
        // 2.添加UICollectionView，用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = self.bounds
    }
}

// MARK : - 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1. 创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        // 2.给cell设置内容
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.frame
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

// MARK : - 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate{
    
    // 开始拖拽,获取偏移量
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    // 监听collection的滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // 1. 定义获取需要的数据
        var progess : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX{ // 左滑
            // 1.计算 progess
            progess = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            // 2.计算 sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            // 3.计算 targetIndex
            targetIndex = sourceIndex + 1
            // 判断防止数组越界
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progess = 1
                targetIndex = sourceIndex
            }
            
        }else{ // 右滑
            // 1.计算 progess
            progess =  1 - currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            // 2.计算 targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            // 3.计算 sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        // 3.将 progess sourceIndex targetIndex 传递给titleView
//        print("progess:\(progess) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        // 调用代理
        delegate?.pageContentView(pageContentView: self, progess: progess, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}









// MARK: 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int)  {
        // 滚动到对应的位置
        let offsetX =  CGFloat(currentIndex)  * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
