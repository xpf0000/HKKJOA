# XRefresh


一.说明: swift版适用于scrollView的刷新类库  借鉴参考了MSRefresh的处理思路 并扩展出进度控制的方法 对于一些下拉刷新展示的GIF动画 
可以做到进度控制 

二. 文件说明:
主要文件:
1. XRefresh.swift
定义了各种回调,状态枚举,全局block和方法 以及对UIScrollView的扩展
2. XHeaderRefreshView
下拉刷新
3. XFooterRefreshView
上拉加载

其余
Source: snapkit类库   
剩下的都是一些方便使用的扩展  

三. 使用说明
直接把三个主要文件添加到项目中 如果要使用默认设置 把down.png也拷贝到项目中

1. 设置下拉刷新:
table.setHeaderRefresh {[weak self]() -> Void in

//做刷新动作
}





