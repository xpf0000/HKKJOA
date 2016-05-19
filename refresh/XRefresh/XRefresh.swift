//
//  XRefresh.swift
//  lejia
//
//  Created by X on 15/9/25.
//  Copyright © 2015年 XSwiftTemplate. All rights reserved.
//

import UIKit

typealias RefreshBlock = ()->Void

typealias RefreshProgressBlock = (UIView,Double)->Void
typealias RefreshViewBlock = (UIView)->Void

//状态
enum XRefreshState : NSInteger{
    case Normal
    case Pulling
    case Refreshing
    case WillRefreshing
    case End
}

private var headerV: XHeaderRefreshView?
private var footerV: XFooterRefreshView?

private var RefreshHeaderViewKey : CChar?
private var RefreshFooterViewKey : CChar?

var XRefreshHeaderProgressBlock:RefreshProgressBlock?
var XRefreshHeaderBeginBlock:RefreshViewBlock?
var XRefreshHeaderEndBlock:RefreshViewBlock?

var XRefreshFooterProgressBlock:RefreshProgressBlock?
var XRefreshFooterBeginBlock:RefreshViewBlock?
var XRefreshFooterEndBlock:RefreshViewBlock?
var XRefreshFooterNoMoreBlock:RefreshViewBlock?

var XRefreshEnable = true

func XRefreshConfig(headerProgress:RefreshProgressBlock?,headerBegin:RefreshViewBlock?,headerEnd:RefreshViewBlock?,footerProgress:RefreshProgressBlock?,footerBegin:RefreshViewBlock?,footerEnd:RefreshViewBlock?,noMore:RefreshViewBlock?)
{
    XRefreshHeaderProgressBlock = headerProgress    ///下拉刷新进度
    XRefreshHeaderBeginBlock = headerBegin          ///下拉刷新开始
    XRefreshHeaderEndBlock = headerEnd              ///下拉刷新结束
    
    XRefreshFooterProgressBlock = footerProgress    ///上拉加载进度
    XRefreshFooterBeginBlock = footerBegin          ///上拉加载开始
    XRefreshFooterEndBlock = footerEnd              ///上拉加载结束
    XRefreshFooterNoMoreBlock = noMore              ///数据全部加载完毕
}

extension UIScrollView
{

    func hideHeadRefresh()
    {
        self.headRefresh?.hide()
    }
    
    func showHeadRefresh()
    {
        self.headRefresh?.show()
    }
    
    func hideFootRefresh()
    {
        self.footRefresh?.hide()
    }
    
    func showFootRefresh()
    {
        self.footRefresh?.show()
    }
    
    func setHeaderRefresh(block:RefreshBlock)
    {
        let headerRefreshView:XHeaderRefreshView=XHeaderRefreshView(frame: CGRectZero)
        self.addSubview(headerRefreshView)
        self.headRefresh=headerRefreshView
        headerRefreshView.block = block
        
    }
    
    weak var headRefresh:XHeaderRefreshView?
        {
        get
        {
            return objc_getAssociatedObject(self, &RefreshHeaderViewKey) as? XHeaderRefreshView
        }
        set(newValue) {
            self.willChangeValueForKey("RefreshHeaderViewKey")
            objc_setAssociatedObject(self, &RefreshHeaderViewKey, newValue,
            .OBJC_ASSOCIATION_ASSIGN)
            self.didChangeValueForKey("RefreshHeaderViewKey")
            
        }
    }
    
    weak var footRefresh:XFooterRefreshView?
        {
        get
        {
            return objc_getAssociatedObject(self, &RefreshFooterViewKey) as? XFooterRefreshView
        }
        set(newValue) {
            self.willChangeValueForKey("RefreshFooterViewKey")
            objc_setAssociatedObject(self, &RefreshFooterViewKey, newValue,
                .OBJC_ASSOCIATION_ASSIGN)
            self.didChangeValueForKey("RefreshFooterViewKey")
            
        }
    }
    
    func beginHeaderRefresh()
    {
        self.headRefresh?.beginRefresh()
    }
    
    func endHeaderRefresh()
    {
        self.headRefresh?.endRefresh()
    }
    
    func setFooterRefresh(block:RefreshBlock)
    {
        let footerRefreshView:XFooterRefreshView=XFooterRefreshView(frame: CGRectMake(0, 0, self.frame.width, 0))
        self.addSubview(footerRefreshView)
        self.footRefresh=footerRefreshView
        footerRefreshView.block=block
    }
    
    func beginFooterRefresh()
    {
        self.footRefresh?.beginRefresh()
    }
    
    func endFooterRefresh()
    {
        self.footRefresh?.endRefresh()
    }
    
    func LoadedAll()
    {
        self.footRefresh?.end = true
        self.footRefresh?.setState(.End)
    }
    
}



