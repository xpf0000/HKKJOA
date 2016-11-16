//
//  NSDate.swift
//  swiftTest
//
//  Created by X on 15/3/11.
//  Copyright (c) 2015年 swiftTest. All rights reserved.
//

import Foundation
extension NSDate
{
    class func now()->NSDate
    {
        let date:NSDate=NSDate()
        let zone:NSTimeZone=NSTimeZone.system as NSTimeZone
        let interval:TimeInterval=TimeInterval(zone.secondsFromGMT(for: date as Date))
        return date.addingTimeInterval(interval)
    }
    
    func formart()->NSDate
    {
        let zone:NSTimeZone=NSTimeZone.system as NSTimeZone
        let interval:TimeInterval=TimeInterval(zone.secondsFromGMT(for: self as Date))
        return self.addingTimeInterval(interval)
    }
    
    var dateComponent:DateComponents
    {
        let calendar=NSCalendar.current

        let unitFlags = Set<Calendar.Component>([.year, .month, .weekday, .day])
        
        let result = calendar.dateComponents(unitFlags, from: self as Date)
        
        return result
    }
    
    var dayCount:Int
        {
            let month=self.dateComponent.month ?? 0
            let year=self.dateComponent.year ?? 0
        
        if month * year == 0 {return 0}
        
            switch (month) {
            case 1:
                return 31
            case 3:
                return 31
            case 4:
                return 30
            case 5:
                return 31
            case 6:
                return 30
            case 7:
                return 31
            case 8:
                return 31
            case 9:
                return 30
            case 10:
                return 31
            case 11:
                return 30
            case 12:
                return 31
            default:
                break
            }
            if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
            {
                return 29
            }
            else {
                return 28
            }
    }
    
    func timeSinceNow(flag:Int)->String
    {
        var str:String=""
        let date:NSDate=self.formart()
        let gregorian:NSCalendar=NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        
        let unitFlags:NSCalendarUnit = [.NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit]
        var comps:NSDateComponents?
        switch(flag)
        {
        case 0:
            comps=gregorian.components(unitFlags, fromDate: date, toDate: NSDate().formart(), options: [])
        case 1:
            comps=gregorian.components(unitFlags, fromDate: NSDate().formart(), toDate: date, options: [])
        default:
            return ""
        }
        
        if(comps?.day>1)
        {
            return "\(comps!.day)天"
        }
        
        if(comps?.hour==0)
        {
            if(comps?.minute>=1)
            {
                str="\(comps!.minute)分钟"
            }
            else if(comps?.minute>=0 && comps?.second>0)
            {
                str="\(comps!.second)秒"
            }
        }
        else if(comps?.hour>0)
        {
            str="\(comps!.hour)小时";
        }
        
        return str == "" ? "0秒" : str
    }
    
    var str:String?
        {
            let dateFormatter:NSDateFormatter=NSDateFormatter()
            dateFormatter.dateFormat="yyyy-MM-dd HH:mm"
            return dateFormatter.stringFromDate(self)
    }
    
    func toStr(format:String)->String?
    {
        let dateFormatter:NSDateFormatter=NSDateFormatter()
        dateFormatter.dateFormat=format
        return dateFormatter.stringFromDate(self)
    }
    
    
    
    
}
