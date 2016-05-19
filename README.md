# XRefresh

一.说明: 

  swift版适用于scrollView的刷新类库 借鉴参考了MJRefresh的处理思路 并扩展出进度控制的方法 对于一些下拉刷新展示的GIF动画,可以做到进度控制
  
  ![image](https://github.com/xpf0000/XRefresh/blob/master/refresh/Refresh.gif)

二. 文件说明:

主要文件: 

  1. XRefresh.swift 

  定义了各种回调,状态枚举,全局block和方法 以及对UIScrollView的扩展 

  2. XHeaderRefreshView 

  下拉刷新 

  3. XFooterRefreshView 

  上拉加载

三. 使用说明 

  直接把三个主要文件添加到项目中 如果要使用默认设置 把down.png也拷贝到项目中

  1. 设置下拉刷新: 
  
  table.setHeaderRefresh {weak self -> Void in

  //做刷新动作 

  }
  
  2. 设置上拉加载:
  
  table.setFooterRefresh { [weak self]() -> Void in
  
  //做加载动作
  
  }
  
  3. 下拉刷新结束
  
  table.endHeaderRefresh()
  
  4. 上拉加载结束
  
  table.endFooterRefresh()
  
  5. 自动开始下拉刷新
  
  table.beginHeaderRefresh()
  
  6. 自动开始上拉加载
  
  table.beginFooterRefresh()
  
  7. 数据全部加载完毕
  
  table.LoadedAll()
  
  8. 实现自定义加载过程(可选 用到就调用这个方法)
  
    XRefreshConfig(

    headerProgress:RefreshProgressBlock?          ///下拉刷新进度

    ,headerBegin:RefreshViewBlock?                ///下拉刷新开始
  
    ,headerEnd:RefreshViewBlock?                  ///下拉刷新结束

    ,footerProgress:RefreshProgressBlock?         ///上拉加载进度

    ,footerBegin:RefreshViewBlock?                ///上拉加载开始

    ,footerEnd:RefreshViewBlock?                  ///上拉加载结束

    ,noMore:RefreshViewBlock?                     ///数据全部加载完

    )
  
    用到哪个实现哪个 其余传nil
  
    自己摸索写的 有不完善的地方大家多多交流 QQ:250881478
  
