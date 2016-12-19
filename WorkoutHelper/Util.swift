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
}
