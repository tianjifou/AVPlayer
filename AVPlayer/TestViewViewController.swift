//
//  TestViewViewController.swift
//  AVPlayer
//
//  Created by 天机否 on 2017/10/20.
//  Copyright © 2017年 tianjifou. All rights reserved.
//

import UIKit
import Masonry
class TestViewViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let btn = UIButton()
        btn.backgroundColor = UIColor.blue
        btn.addTarget(self, action: #selector(test), for: .touchUpInside)
        self.view.addSubview(btn)
        
        btn.mas_makeConstraints { (make) in
            make!.width.mas_equalTo()(CGSize.init(width: 100, height: 50))
            make!.center.equalTo()
        }
    }
    @objc func test(){
       
        self.dismiss(animated: false, completion: nil)
        UIApplication.shared.delegate?.window??.subviews.forEach({ (view) in
            print(Unmanaged.passUnretained(view).toOpaque())
            view.removeFromSuperview()
        })
        UIApplication.shared.delegate?.window??.rootViewController = TJFHomeViewController()


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("释放TestViewViewController")
    }

}
