//
//  VC1.swift
//  refresh
//
//  Created by X on 16/4/29.
//  Copyright © 2016年 refresh. All rights reserved.
//

import Foundation
import UIKit


class VC1: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var table: UITableView!
    
    let a = A()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        
        table = UITableView()
        table.frame=CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-120)
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        
        table.snp_makeConstraints { (make) in
            make.top.equalTo(0.0)
            make.bottom.equalTo(0.0)
            make.trailing.equalTo(0.0)
            make.leading.equalTo(0.0)
        }
        
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        table.tableFooterView = view
        table.tableHeaderView = view
        
        
        self.table.setHeaderRefresh {[weak self]() -> Void in
            
            if self == nil {return}
            
            print("刷新开始!!!!!!!")

            self?.performSelector(#selector(VC1.refresh), withObject: nil, afterDelay: 2.0)
        }
        
        self.table.setFooterRefresh { [weak self]() -> Void in
            
          self?.performSelector(#selector(VC1.refresh), withObject: nil, afterDelay: 4.0)
            
        }
        
        self.table.LoadedAllDate()
        
    }
    
    
    func refresh()
    {
        self.table.endHeaderRefresh()
        self.table.endFooterRefresh()
        print("刷新结束!!!!!!!!!!")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = VC2()
        self.showViewController(vc, sender: nil)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    deinit
    {
        print("VC1 deinit !!!!!!!!")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}