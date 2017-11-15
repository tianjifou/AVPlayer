//
//  ViewController.swift
//  AVPlayer
//
//  Created by 天机否 on 2017/9/28.
//  Copyright © 2017年 tianjifou. All rights reserved.
//

import UIKit
@objc
protocol NavBarHideDelegate:NSObjectProtocol {
   @objc optional func scrollViewDidScrollForNavBarHide(_ scrollView: UIScrollView)
}
class ViewController: UIViewController {
    var homeTable:UITableView!
    weak var delegate:NavBarHideDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        homeTable = UITableView()
        homeTable.delegate = self
        homeTable.dataSource = self
        homeTable.estimatedRowHeight = 0
        homeTable.rowHeight = 44
        homeTable.separatorStyle = .none
        homeTable.backgroundColor = UIColor.brown
        homeTable.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        self.view.addSubview(homeTable)
        
        homeTable.mas_makeConstraints { (make) in
                    make!.left.top().right().bottom().equalTo()
                }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
}
extension ViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.scrollViewDidScrollForNavBarHide!(scrollView)
    }
   
}

