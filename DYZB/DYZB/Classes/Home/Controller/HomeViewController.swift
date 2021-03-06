//
//  HomeViewController.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/11.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

private let KTitleViewH :CGFloat = 40

class HomeViewController: UIViewController {

    // MARK: - 懒加载属性
    // titleView
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: KNewSatusBarH + KnavigationBar, width: KSreenW, height: KTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    // pageContentView
   
    private lazy var pageContentView : PageContentView = { [weak self] in
        // 1.确定内容显示的frame
        let contentH = KSreenH - KNewSatusBarH - KnavigationBar - KTitleViewH - KTabbarH
        let contentFrame = CGRect(x: 0, y: KNewSatusBarH + KnavigationBar + KTitleViewH, width: KSreenW, height: contentH)
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        for _ in 0..<2{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    
    
    
    // MARK : 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        setupUI()
    }

}



// MARK:-设置UI界面
extension HomeViewController {
    
    private func setupUI(){
        // 1.设置导航栏
        setupNavigationBar()
        // 2.添加titleView
        view.addSubview(pageTitleView)
        // 3.添加contentView
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar(){
        // 1.设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.设置右侧的item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}

// MARK: -遵守pageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        // 调用 pageContentView 暴露的方法
        pageContentView.setCurrentIndex(currentIndex: index)
    } 
}

// MARK : - 遵守pageContentView协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(pageContentView: PageContentView, progess: CGFloat, sourceIndex: Int, targetIndex: Int) {
        // 调用 pageTitleView 暴露的方法
       pageTitleView.setTitleViewProgress(progress: progess, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
