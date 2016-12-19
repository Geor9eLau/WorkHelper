//
//  Extension.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/15.
//  Copyright © 2016年 George. All rights reserved.
//

import Foundation

extension Array {
     func removeSameStringElement(targetArr: [String]) -> [String] {
        var tmpArr = [String]()
        var isSame: Bool
        for element in self {
            let eleStr = element as? String
            guard (eleStr != nil) else {return [String]()}
            
            if targetArr.count == 0 {
                tmpArr.append(eleStr!)
                continue
            }
            else{
                isSame = false
                for targetElementStr in targetArr {
                    if targetElementStr == eleStr {
                        isSame = true
                        break
                    }
                }
                if isSame == false {
                    tmpArr.append(eleStr!)
                }
            }
        }
        return tmpArr
    }
}
