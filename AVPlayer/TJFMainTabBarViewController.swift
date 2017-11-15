//
//  TJFMainTabBarViewController.swift
//  AVPlayer
//
//  Created by 天机否 on 2017/9/29.
//  Copyright © 2017年 tianjifou. All rights reserved.
//

import UIKit

class TJFMainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       let firstVC = TJFHomeViewController()
       self.setTabbarItem(tabBarItem: firstVC.tabBarItem, title: "首页", size: 16, selectImage:"icon_gzt2", selectTitleColor: UIColor.blue, normalImage: "icon_gzt1", normalTitleColor: UIColor.black)
       let nav1 = TJFBaseNavigationViewController.init(rootViewController: firstVC)
        let secondVC = TJFMyViewController()
        secondVC.title = "个人中心"
        self.setTabbarItem(tabBarItem: secondVC.tabBarItem, title: "个人中心", size: 16, selectImage: "icon_wd2", selectTitleColor: UIColor.blue, normalImage: "icon_wd1", normalTitleColor: UIColor.black)
        let nav2 = TJFBaseNavigationViewController.init(rootViewController: secondVC)
        
        self.viewControllers = [nav1,nav2]
    }
    
    func setTabbarItem(tabBarItem: UITabBarItem,title:String,size:CGFloat,selectImage:String,selectTitleColor:UIColor,normalImage:String,normalTitleColor:UIColor) {
//        tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:normalTitleColor,NSAttributedStringKey.font: UIFont.systemFont(ofSize: size)], for: .normal)
//        tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:selectTitleColor,NSAttributedStringKey.font:UIFont.systemFont(ofSize: size)], for: .selected)
            tabBarItem.title = title
            tabBarItem.image = UIImage.init(named: normalImage)
            tabBarItem.selectedImage = UIImage.init(named: selectImage)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
