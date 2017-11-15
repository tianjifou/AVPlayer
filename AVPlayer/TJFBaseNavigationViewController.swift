//
//  TJFBaseNavigationViewController.swift
//  AVPlayer
//
//  Created by 天机否 on 2017/9/29.
//  Copyright © 2017年 tianjifou. All rights reserved.
//

import UIKit

class TJFBaseNavigationViewController: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {
    var isPushing: Bool = false
    typealias CustomLeftBackButtonAction  = (() -> Void)
    var clickAction:CustomLeftBackButtonAction?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
        interactivePopGestureRecognizer?.isEnabled = true
        self.navigationBar.isTranslucent = false
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if isPushing {
            return
        } else {
            isPushing = true
        }
        if viewController.navigationItem.leftBarButtonItem == nil, viewControllers.count > 0{
            viewController.navigationItem.setLeftBarButton(customLeftBackButton(clickAction: nil), animated: true)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func getScreenEdgePanGestureRecognizer() -> UIScreenEdgePanGestureRecognizer? {
        if let gestureRecognizers = view.gestureRecognizers {
            
            for ges in gestureRecognizers {
                if ges is UIScreenEdgePanGestureRecognizer {
                    return ges as? UIScreenEdgePanGestureRecognizer
                }
            }
        }
        return nil
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            if viewControllers.count == 1 ||
                topViewController?.presentedViewController != nil {
                return false
            }
        }
        return true
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        isPushing = false
    }
    func customLeftBackButton(clickAction: CustomLeftBackButtonAction?) -> UIBarButtonItem {
        self.clickAction = clickAction
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30.0, height: 18.0)
        button.addTarget(self, action: #selector(clickEvent), for: .touchUpInside)
       
        button.setImage(UIImage(named:"back_leftButton"), for: .normal)
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = .left
        // 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0)
        let backButton = UIBarButtonItem(customView: button)
        return backButton
    }
    
    @objc func clickEvent(){
        if let clickAction = clickAction {
            clickAction()
        } else {
            _ = self.popViewController(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
