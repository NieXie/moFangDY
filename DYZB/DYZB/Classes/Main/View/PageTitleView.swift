//
//  PageTitleView.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/11.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

// 定义协议
protocol PageTitleViewDelegate :class{
    // 代理方法
    func pageTitleView(titleView : PageTitleView , selectedIndex index : Int)
}

// 滚动条的高度
private let KScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    
    // 定义下标值
    private var currentIndex : Int = 0
    // MARK : 定义属性来保存接收的数据
    private var titles : [String]
    // 定义代理属性
    weak var delegate : PageTitleViewDelegate?
    // MARK: 懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    private lazy var scrollview : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.scrollsToTop = false
        scrollview.bounces = false
        return scrollview
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()

    // MARK : - 自定义构造函数
    init(frame: CGRect,titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI界面
extension PageTitleView {
    private func setupUI(){
        // 1.添加UIScrollview
        addSubview(scrollview)
        scrollview.frame = bounds
        // 2.添加title到对应的label
        setupTitleLabels()
        // 3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    private func setupTitleLabels(){
        
        // 0.确定label的一些Frame值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - KScrollLineH
        let labelY : CGFloat = 0
        
        // 通过循环拿到对应的label
        for (index,title) in titles.enumerated(){
            // 1.创建UILabel
            let label = UILabel()
            // 2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            // 3.设置label的Frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            // 4.将label添加到scrollView中
            scrollview.addSubview(label)
            // 5.添加到存放label的数组中
            titleLabels.append(label)
            // 6.添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine(){
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollviewLine
        scrollview .addSubview(scrollLine)
        // 2.1 获取第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KScrollLineH, width: firstLabel.frame.width, height: KScrollLineH)
    }
}

// MARK : - 监听label的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes:UITapGestureRecognizer){
        // 1.获取当前label
        guard let currentLab = tapGes.view as? UILabel else {return}
        
        // 2.获取之前的label
        let oldLab = titleLabels[currentIndex]
        
        // 3.切换文字的颜色
        currentLab.textColor = UIColor.orange
        oldLab.textColor = UIColor.darkGray
        
        //4. 保存最新lab的下标值
        currentIndex = currentLab.tag
        
        //5.滚动条位置发生改变
        let scrollLineX =  CGFloat(currentLab.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6. 通知代理做事情
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
