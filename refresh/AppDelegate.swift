//
//  AppDelegate.swift
//  refresh
//
//  Created by X on 16/1/15.
//  Copyright © 2016年 refresh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let data = NSData(contentsOfFile: "loading.gif".path)
        let img = UIImageView(frame: CGRectZero)
        let g = XImageGifPlayer(hash: "loading.gif".hash, data: data!, img: img)
        let t = Double(100.0) / Double(60.0)
        
        XRefreshConfig({ (view, p) in
            
            let n = g.gif.count - Int(ceil(p*100.0 / t)) % g.gif.count
            
            if view.subviews.count == 0
            {
                img.image = UIImage(contentsOfFile: "loading.gif".path)
                img.contentMode = .Center
                img.layer.masksToBounds = true
                view.addSubview(img)
                img.tag = 20
                img.snp_makeConstraints(closure: { (make) in
                    make.center.equalTo(view)
                    make.width.equalTo(view.snp_height)
                    make.height.equalTo(img.snp_width)
                })
                
                g.ind = n-1
                g.play()
                
            }
            else
            {
                if p < 1.0
                {
                    g.ind = n-1
                    g.play()
                }
            }
            ///////
            }, headerBegin: { (view) in
                g.ind = 0
                g.rePlay()
             ////
            }, headerEnd: { (view) in
                g.timer?.invalidate()
                g.timer = nil
               ///
            }, footerProgress: nil, footerBegin: nil, footerEnd: nil, noMore: nil)
        
        
        
        
//        XRefreshHeaderProgressBlock = {
//        (view,p)->Void in
//            
//            let n = g.gif.count - Int(ceil(p*100.0 / t)) % g.gif.count
//            
//            if view.subviews.count == 0
//            {
//                img.image = UIImage(contentsOfFile: "loading.gif".path)
//                img.contentMode = .Center
//                img.layer.masksToBounds = true
//                view.addSubview(img)
//                img.tag = 20
//                img.snp_makeConstraints(closure: { (make) in
//                    make.center.equalTo(view)
//                    make.width.equalTo(view.snp_height)
//                    make.height.equalTo(img.snp_width)
//                })
//
//                g.ind = n-1
//                g.play()
//                
//            }
//            else
//            {
//                if p < 1.0
//                {
//                    g.ind = n-1
//                    g.play()
//                }
//            }
//            
//        }
//        
//        XRefreshHeaderBeginBlock = {
//            (view)->Void in
//            
//            g.ind = 0
//            g.rePlay()
//            
//        }
//        
//        XRefreshHeaderEndBlock = {
//            (view)->Void in
//            
//            g.timer?.invalidate()
//            g.timer = nil
//            
//        }

//        XRefreshFooterProgressBlock = {
//            (view,p)->Void in
//            
//            print("Footer view count: \(view.subviews.count) | p: \(p)")
//            
//        }
        
//        XRefreshFooterBeginBlock = {
//            (view)->Void in
//            
//           print("Footer refresh begin !!!!")
//            
//        }
//        
//        XRefreshFooterEndBlock = {
//            (view)->Void in
//            
//            print("Footer refresh end !!!!")
//            
//        }
//        
//        XRefreshFooterNoMoreBlock = {
//            (view)->Void in
//            
//            print("Footer refresh NoMore !!!!")
//            
//        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

