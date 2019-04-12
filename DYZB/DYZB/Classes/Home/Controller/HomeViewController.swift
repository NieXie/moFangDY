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
    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: KSatusBarH + KnavigationBar, width: KSreenW, height: KTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    // pageContentView
   
    private lazy var pageContentView : PageContentView = {
        // 1.确定内容显示的frame
        let contentH = KSreenH - KSatusBarH - KnavigationBar - KTitleViewH
        let contentFrame = CGRect(x: 0, y: KSatusBarH + KnavigationBar + KTitleViewH, width: KSreenW, height: contentH)
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
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
