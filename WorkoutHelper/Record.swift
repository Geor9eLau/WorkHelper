//
//  Record.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/15.
//  Copyright © 2017年 George. All rights reserved.
//

import Foundation


class Record: NSObject, NSCoding{
    var motion: PartMotion
    var maxWeight: Double = 0
    var totalRepeats: UInt = 0
    var totalTimeConsuming: UInt = 0
    
    init(motion: PartMotion){
        self.motion = motion
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        motion = aDecoder.decodePartMotion(forKey: "motion")!
        maxWeight = aDecoder.decodeObject(forKey: "maxWeight") as! Double
        totalRepeats = aDecoder.decodeObject(forKey: "totalRepeats") as! UInt
        totalTimeConsuming = aDecoder.decodeObject(forKey: "totalTimeConsuming") as! UInt
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encodePartMotion(partMotion: motion, forkey: "motion")
        aCoder.encode(maxWeight, forKey: "maxWeight")
        aCoder.encode(totalRepeats, forKey: "totalRepeats")
        aCoder.encode(totalTimeConsuming, forKey: "totalTimeConsuming")
    }
}
