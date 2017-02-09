//
//  Util.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/14.
//  Copyright © 2016年 George. All rights reserved.
//

import Foundation
import UIKit

class Util: NSObject {
    static func RGBColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor{
        return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    static func transformDateStrToDate(dateStr: String) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dateStr)!
    }
    
    static func transformDateToDateStr(date: Date) -> String{
        let dateMatter = DateFormatter()
        dateMatter.dateFormat = "yyyy-MM-dd"
        return dateMatter.string(from: date)
    }
    
//    static func showAlert(message: String,
//                          confirmHandler: @escaping () -> ()){
//        let alertC = UIAlertController(title: "", message: message, preferredStyle: .alert)
//        let confirmAction = UIAlertAction(title: "", style: .default) { (confirm) in
//            confirmHandler()
//        }
//        let cancelConfirmAction = UIAlertAction(title: "", style: .cancel) { (cancelAction) in
//            alertC.
//        }
//        alertC.
//    }
    
    
    
    
    
}









