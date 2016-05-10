//
//  XFooterRefreshView.swift
//  refresh
//
//  Created by X on 16/1/15.
//  Copyright © 2016年 refresh. All rights reserved.
//

import UIKit


class XFooterRefreshView: UIView {
    
    weak var scrollView:UIScrollView?
    let msgLabel:UILabel=UILabel()
    let activity:UIActivityIndicatorView=UIActivityIndicatorView()
    var block:RefreshBlock?
    var state:XRefreshState = .Normal
    var end=false
    var height:CGFloat = 60
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    func hide()
    {
        self.hidden = true
    }
    
    func show()
    {
        self.hidden = false
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        
        self.scrollView = newSuperview as? UIScrollView
        
        if(newSuperview != nil)
        {
            newSuperview!.addObserver(self, forKeyPath: "contentSize", options: .New, context: nil)
            newSuperview!.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
            newSuperview!.sendSubviewToBack(self)
            self.frame.origin.y = newSuperview!.frame.size.height;
        }
        else
        {
            self.superview?.removeObserver(self, forKeyPath: "contentSize")
            self.superview?.removeObserver(self, forKeyPath: "contentOffset")
        }
    }
    
    override func removeFromSuperview() {
        
        super.removeFromSuperview()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor=UIColor.clearColor()
        
        if XRefreshFooterProgressBlock != nil
        {
            return
        }
        
        msgLabel.text="上拉加载更多"
        msgLabel.textColor="33475f".color
        msgLabel.textAlignment=NSTextAlignment.Center
        msgLabel.font=UIFont.boldSystemFontOfSize(15)
        
        self.addSubview(msgLabel)
        
        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray;
        activity.alpha=0.0
        
        self.addSubview(activity)
        
        msgLabel.snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        activity.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.trailing.equalTo(msgLabel.snp_leading).offset(-15.0)
        }
  
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if(self.scrollView == nil)
        {
            return
        }
        
        if(keyPath == "contentSize")
        {
            if self.scrollView!.contentSize.height < self.scrollView!.frame.size.height
            {
                self.scrollView!.contentSize.height = self.scrollView!.frame.size.height
            }
            
            self.frame=CGRectMake(0, scrollView!.contentSize.height, scrollView!.frame.size.width, height)
            
        }
        
        if(keyPath == "contentOffset")
        {
            
            if(self.state == .End || !XRefreshEnable || self.hidden)
            {
                print("XRefreshEnable is false")
                
                return
            }
            
            let y:CGFloat = scrollView!.contentOffset.y
            var sizeY:CGFloat = scrollView!.contentSize.height-scrollView!.frame.height
            sizeY = sizeY < 0 ? 0 : sizeY
 
            if y <= 0
            {
                return
            }
            
            XRefreshFooterProgressBlock?(self,Double((y-sizeY)/height))
            
            if (scrollView!.dragging)
            {
                
                if (self.state == .Normal && y >= sizeY+height)
                {
                    self.setState(.Pulling)
                }
                else if (self.state == .Pulling && y < sizeY+height)
                {
                    self.setState(.Normal)
                }
            }
            else if(self.state == .Pulling)
            {
                self.setState(.Refreshing)
            }
        }
    }
    
    func beginRefresh()
    {
        if(self.window != nil)
        {
            self.setState(.Refreshing)
        }
        else
        {
            self.state = .WillRefreshing
            super.setNeedsDisplay()
        }
    }
    
    func endRefresh()
    {
        let delayInSeconds:Double=0.25
        let popTime:dispatch_time_t=dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        
        dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
            
            self.setState(.Normal)
            
        })
    }
    
    func reSet()
    {
        self.state = .Normal
        self.activity.alpha=0.0
        self.activity.stopAnimating()
        self.scrollView!.contentInset.bottom = 0
        self.setStateText()
    }
    
    func setState(state:XRefreshState)
    {
        if self.state ==  state || self.state == .End
        {
            return
        }
        
        switch state
        {
        case .Normal:
            
            if(self.state == .Refreshing)
            {
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.activity.alpha=0.0
                    self.scrollView!.contentInset.bottom = 0
                    
                    }, completion: { (finish) -> Void in
                        
                        self.activity.stopAnimating()
                        
                })
                
                let delayInSeconds:Double=0.25
                let popTime:dispatch_time_t=dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
                
                dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                    
                    XRefreshFooterEndBlock?(self)
                    
                    self.state = .Pulling
                    self.setState(.Normal)
                    
                    XRefreshEnable = true
                    
                })
   
            }
            else
            {
                self.activity.alpha=0.0
                self.activity.stopAnimating()
            }
            
            
        case .Pulling:
            ""
            
        case .Refreshing:
            
            XRefreshEnable = false
            
            self.activity.hidden = false
            self.activity.alpha=1.0
            self.activity.startAnimating()

            UIView.animateWithDuration(0.25, animations: { () -> Void in
                

                self.scrollView!.contentInset.bottom=self.height
                
                var y:CGFloat = self.scrollView!.contentSize.height-self.scrollView!.frame.height+self.height
                
                if y < 0 && y > -64
                {
                    y = 64 + y
                }
                else if y < -64
                {
                    y = self.height
                }
                
                self.scrollView?.setContentOffset(CGPointMake(0, y), animated: false)
                
                }, completion: { (finish) -> Void in
                    
                    XRefreshFooterBeginBlock?(self)
                    self.block?()
            })
            
        case .WillRefreshing:
            ""
            
        case .End:
            
            self.activity.stopAnimating()
            self.activity.hidden = true
            self.scrollView!.contentInset.bottom=0
            XRefreshFooterNoMoreBlock?(self)
        }
        self.state=state
        
        self.setStateText()
    }
    
    func setStateText()
    {
        switch self.state
        {
        case .Normal:
            
            self.msgLabel.text = "上拉加载更多"
            
        case .Pulling:
            
            self.msgLabel.text = "松开进行加载"
            
        case .Refreshing:
            
            self.msgLabel.text = "正在玩命加载"
            
        case .WillRefreshing:
            ""
        case .End:
            self.msgLabel.text = "已无更多内容"
            
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        if (self.state == .WillRefreshing) {
            self.setState(.Refreshing)
        }
    }
    
    
    deinit
    {
        print("XRefresh Footer deinit!!!!!!!!")
        
        self.superview?.removeObserver(self, forKeyPath: "contentSize")
        self.superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        self.scrollView = nil
        self.block = nil
        self.removeFromSuperview()
        
    }
    
    
}

