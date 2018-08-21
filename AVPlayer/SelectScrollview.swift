//
//  SelectScrollview.swift
//  AVPlayer
//
//  Created by 天机否 on 2017/10/10.
//  Copyright © 2017年 tianjifou. All rights reserved.

import UIKit
import Masonry
class SelectScrollview:UIView{
    var viewControllers:[UIViewController]?
    var arrTitle:[String]?
    fileprivate static let btnTag = 100
    fileprivate let screenWidth = UIScreen.main.bounds.size.width
    fileprivate var isClick = false
    fileprivate var kWidthArr:[CGFloat] = []
    fileprivate var bWidthArr:[CGFloat] = []
    fileprivate var kPointArr:[CGFloat] = []
    fileprivate var bPointArr:[CGFloat] = []
    fileprivate var btnWidth:[CGFloat] = []
    fileprivate var btnCenter:[CGFloat] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        guard let viewControllers = viewControllers,viewControllers.count > 0 else {return}
        super.layoutSubviews()
        let width = CGFloat(viewControllers.count)*screenWidth
        let height = self.bounds.size.height  - 88
        viewConrtollerScroll.contentSize = CGSize.init(width: width, height: height)
        
        for (_,vc) in dicForVC {
            vc.view.mas_updateConstraints({ (make) in
             make!.size.mas_equalTo()(CGSize.init(width: self.screenWidth, height: self.bounds.size.height - 44))            })
        }
    }
    
    
     func createUI() {
        guard let viewControllers = viewControllers,viewControllers.count > 0 else {return}
        self.addSubview(topScrollView)
        topScrollView.mas_makeConstraints { (make) in
            make!.left.equalTo()(10)
            make!.right.equalTo()(-10)
            make!.top.equalTo()
            make!.height.equalTo()(44)
        }
        createtopScrollBtn()
        topScrollView.addSubview(topAnotherScrollView)
        createtopAnotherScrollBtn()
        topAnotherScrollView.addSubview(bottomView)
        bottomView.mas_makeConstraints { (make) in
            make!.left.right().bottom().equalTo()
            make!.height.equalTo()(4)
        }
        let width = CGFloat(viewControllers.count)*screenWidth
        let height = self.bounds.size.height  - 88
        viewConrtollerScroll.contentSize = CGSize.init(width: width, height: height)
        self.addSubview(viewConrtollerScroll)
        viewConrtollerScroll.mas_makeConstraints { (make) in
            make!.left.right().bottom().equalTo()
            make!.top.equalTo()(self.topScrollView.mas_bottom)
        }
        xianXinHanShu()
        self.currentPage = 0
    }
    
    public func xianXinHanShu() {
        guard let arrTitle = arrTitle else {return}
        
        for index in 0..<arrTitle.count - 1 {
            let startPointX = btnCenter[index] - btnWidth[index]/2
            let endPointX = btnCenter[index+1] + btnWidth[index+1]/2
            let distance = endPointX - startPointX
            let midpointX =  startPointX + distance/2
            let width = screenWidth
            let k1 = 2*(distance - btnWidth[index])/width
            let b1 = btnWidth[index] - k1 * CGFloat(2*index) * width/2
            kWidthArr.append(k1)
            bWidthArr.append(b1)
            
            let k2 = 2*( btnWidth[index+1] - distance )/width
            let b2 = distance - k2 * CGFloat(2*index+1) * width/2
            kWidthArr.append(k2)
            bWidthArr.append(b2)
            
            let k11 = 2*(midpointX - btnCenter[index])/width
            let b11 = btnCenter[index] - k11 * CGFloat(2*index)*width/2
            kPointArr.append(k11)
            bPointArr.append(b11)
            
            let k22 = 2*( btnCenter[index+1] - midpointX )/width
            let b22 = midpointX - k22 * CGFloat(2*index+1)*width/2
            kPointArr.append(k22)
            bPointArr.append(b22)
            
        }
    }
    
    public func createtopScrollBtn() {
        guard let arrTitle = arrTitle else {return}
        var tempBtn:UIButton?
        var widthTotal:CGFloat = 0
        for (index,title) in arrTitle.enumerated() {
            let btn = UIButton()
            btn.tag = SelectScrollview.btnTag + index
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.titleLabel?.textAlignment = .center
            btn.addTarget(self, action: #selector(btnSelector(btn:)), for: .touchUpInside)
            topScrollView.addSubview(btn)
            let width = (title as NSString).size(withAttributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13)]).width+4
            btnWidth.append(width)
            btnCenter.append(width/2+widthTotal)
            widthTotal += width + 10
            
            btn.mas_makeConstraints({ (make) in
                if let tempBtn = tempBtn {
                    make!.left.equalTo()(tempBtn.mas_right)!.offset()(10)
                }else {
                    make!.left.equalTo()
                }
                make!.top.equalTo()
                make!.width.equalTo()(width)
                make!.height.equalTo()(44)
            })
            tempBtn = btn
            topScrollView.contentSize = CGSize.init(width: widthTotal-10, height: 44)
        }
        
        
    }
    
    @objc func btnSelector(btn:UIButton){
        let btnCenterX = btn.center.x
        let topScrollWidth = topScrollView.frame.size.width
        let topScrollConsizeWidth = topScrollView.contentSize.width
        
        if btnCenterX < topScrollWidth/2 {
            topScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }else if btnCenterX + topScrollWidth/2 < topScrollConsizeWidth {
            topScrollView.setContentOffset(CGPoint.init(x: btnCenterX-topScrollWidth/2, y: 0), animated: true)
            
        }else {
            topScrollView.setContentOffset(CGPoint.init(x: topScrollConsizeWidth-topScrollWidth, y: 0), animated: true)
        }
        isClick = true
        self.layoutIfNeeded()
        topAnotherScrollView.mas_updateConstraints { (make) in
            make!.centerX.equalTo()(self.topScrollView.mas_left)!.offset()(btnCenterX)
            make!.width.equalTo()(btn.frame.width)
        }
        viewConrtollerScroll.contentOffset.x = CGFloat(btn.tag - SelectScrollview.btnTag)*screenWidth
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
        
    }
    
   
    
    lazy var topScrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.delegate = self
        scroll.alwaysBounceHorizontal = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.backgroundColor = UIColor.clear
        return scroll
    }()
    
  
    
    public func createtopAnotherScrollBtn() {
        guard let arrTitle = arrTitle,arrTitle.count > 0 else {return}
        
        let widthFirst = (arrTitle[0] as NSString).size(withAttributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13)]).width+4
        topAnotherScrollView.mas_makeConstraints { (make) in
            make!.top.equalTo()(0)
            make!.centerX.equalTo()(self.topScrollView.mas_left)!.offset()(widthFirst/2)
            make!.width.equalTo()(widthFirst)
            make!.height.equalTo()(44)
        }
        var tempBtn:UIButton?
        var widthTotal:CGFloat = 0
        for title in arrTitle {
            let btn = UIButton()
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.blue, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.titleLabel?.textAlignment = .center
            topAnotherScrollView.addSubview(btn)
            let width = (title as NSString).size(withAttributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13)]).width+4
            widthTotal += width + 10
            btn.mas_makeConstraints({ (make) in
                if let tempBtn = tempBtn {
                    make!.left.equalTo()(tempBtn.mas_right)!.offset()(10)
                }else {
                    make!.left.equalTo()(self.topScrollView.mas_left)
                }
                make!.top.equalTo()
                make!.width.equalTo()(width)
                make!.height.equalTo()(44)
            })
            tempBtn = btn
        }
        
    }
    
    
    lazy var topAnotherScrollView:UIView = {
        let scroll = UIView()
        scroll.clipsToBounds = true
        return scroll
    }()
    
    lazy var bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    lazy var viewConrtollerScroll:UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = true
        scroll.alwaysBounceHorizontal = true
        scroll.delegate = self
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    fileprivate var dicForVC:[Int:UIViewController] = [:]
    
    fileprivate var currentPage:Int = -1 {
        didSet {
            if let vc = self.viewControllers {
                guard let _ = dicForVC[currentPage]  else {
                  dicForVC[currentPage] = vc[currentPage]
                    self.viewConrtollerScroll.addSubview(vc[currentPage].view)
                    vc[currentPage].view.mas_makeConstraints({ (make) in
                        make!.left.equalTo()(CGFloat(self.currentPage)*self.screenWidth)
                        make!.top.equalTo()
                        make!.size.mas_equalTo()(CGSize.init(width: self.screenWidth, height: self.bounds.size.height - 44))
                    })
                    
                  return
                }
            }
        }
    }
    
    fileprivate func widthInfor(offsetX:CGFloat) -> CGFloat {
        if kPointArr.count == 0 || bPointArr.count == 0{
            return 0
        }
        var index = Int(offsetX*1.999/self.frame.width)
        if index >= kPointArr.count {
            index = kPointArr.count - 1
        }
        let k = kWidthArr[index]
        let b = bWidthArr[index]
        return k*offsetX + b
    }
    
    fileprivate func centerInfor(offsetX:CGFloat) -> CGFloat {
        if kPointArr.count == 0 || bPointArr.count == 0{
            return 0
        }
        var index = Int(offsetX*1.999/self.frame.width)
        if index >= kPointArr.count {
            index = kPointArr.count - 1
        }
        
        let k = kPointArr[index]
        let b = bPointArr[index]
        
        return k*offsetX + b
    }
}

extension SelectScrollview: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == viewConrtollerScroll {
            if scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width - topScrollView.frame.width {
                return
            }
            self.currentPage  = Int((scrollView.contentOffset.x + screenWidth/2)/screenWidth)
            if isClick {
                isClick = false
                return
            }
            
            topAnotherScrollView.mas_updateConstraints { (make) in
                make!.centerX.equalTo()(self.topScrollView.mas_left)!.offset()(self.centerInfor(offsetX: scrollView.contentOffset.x))
                make!.width.equalTo()(self.widthInfor(offsetX: scrollView.contentOffset.x))
            }
            let   btnCenterX = self.centerInfor(offsetX: scrollView.contentOffset.x)
            let  topScrollWidth = topScrollView.frame.width
            let topScrollConsizeWidth = topScrollView.contentSize.width
            if btnCenterX < topScrollWidth/2 {
                topScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            }else if btnCenterX + topScrollWidth/2 < topScrollConsizeWidth {
                topScrollView.setContentOffset(CGPoint.init(x: btnCenterX-topScrollWidth/2, y: 0), animated: true)
                
            }else {
                topScrollView.setContentOffset(CGPoint.init(x: topScrollConsizeWidth-topScrollWidth, y: 0), animated: true)
            }
            
        }
    }
    
 
}

