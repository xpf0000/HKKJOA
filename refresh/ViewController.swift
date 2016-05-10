//
//  ViewController.swift
//  refresh
//
//  Created by X on 16/1/15.
//  Copyright © 2016年 refresh. All rights reserved.
//

import UIKit


class A: NSObject {
    
    let a = 0
    
}

class ViewController: UIViewController {

    private var timer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(100, 100, 120, 60)
        button.setTitle("button", forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        button.addTarget(self, action: #selector(ViewController.click), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
        
        
    }
    
    func click()
    {
        let vc = VC1()
        
        self.showViewController(vc, sender: nil)
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

