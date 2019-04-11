//
//  MainViewController.swift
//  DYZB
//
//  Created by 李锦萌 on 2019/4/11.
//  Copyright © 2019 ShareBonusNetWork. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profire")
    }
    
    private func addChildVC( storyName: String) {
        // 1.通过storyboard 获取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChild(childVC)
    }
}
