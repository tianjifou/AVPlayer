//
//  TJFHomeViewController.swift
//  AVPlayer
//
//  Created by 天机否 on 2017/9/29.
//  Copyright © 2017年 tianjifou. All rights reserved.
//

import UIKit
import Masonry
let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
var isIPHONE_X: Bool {
    return UIScreen.instancesRespond(to: #selector(getter: UIDynamicItem.bounds)) ? CGSize(width: 375, height: 812).equalTo(UIScreen.main.bounds.size) : false
}
class TJFHomeViewController: UIViewController {
    var botomView:SelectScrollview!
    let barHeight = isIPHONE_X ? -88 : -44
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "首页"
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        botomView = SelectScrollview()
        botomView.arrTitle = ["首页","电影","电视剧","动漫","综艺","首页","电影","电视剧","动漫","综艺","首页","电影","电视剧","动漫","综艺"]
        var arr:[UIViewController] = []
        for index in 0..<botomView.arrTitle!.count {
            if index%2 == 0 {
                let vc = ViewController()
                vc.delegate = self
                arr.append(vc)
            }else {
                let vc = TJFMyViewController()
                arr.append(vc)
            }
        }
        botomView.viewControllers = arr
        self.view.addSubview(botomView)
      
        botomView.mas_makeConstraints { (make) in
            make!.right.left().equalTo()
            make!.top.equalTo()(0)
            make!.bottom.equalTo()(self.barHeight)
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
         self.botomView.createUI()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}

extension TJFHomeViewController:NavBarHideDelegate {
    func scrollViewDidScrollForNavBarHide(_ scrollView: UIScrollView) {
        let _ = scrollView.panGestureRecognizer.velocity(in: self.view).y
        if scrollView.contentOffset.y > 0 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            setStatusBackgroundColor(true)
            self.view.layoutIfNeeded()
            self.botomView.mas_updateConstraints({ (make) in
                make!.top.equalTo()(statusBarHeight)
            })

            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            setStatusBackgroundColor(false)
            self.view.layoutIfNeeded()
            self.botomView.mas_updateConstraints({ (make) in
                make!.top.equalTo()(0)
            })

            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    func setStatusBackgroundColor(_ isHiden:Bool){
        if let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as? UIView)?.value(forKey: "statusBar") as? UIView{
            if statusBar.responds(to: #selector(setter: UIView.backgroundColor)){
                if isHiden{
                    statusBar.backgroundColor = UIColor.white
                }else{
                    statusBar.backgroundColor = UIColor.clear
                }
                
            }
        }
    }

}





