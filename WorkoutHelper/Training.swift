//
//  Training.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/13.
//  Copyright © 2016年 George. All rights reserved.
//

import Foundation

public enum BodyPart: String {
    case leg
    case back
    case shoulder
    static public func ==(lhs: BodyPart, rhs: BodyPart) -> Bool{
        return lhs.rawValue == rhs.rawValue
    }
}

public enum LegMotion: String, PartMotion{
    public var part: BodyPart {
        return .leg
    }
    
    public var motionName: String {
        return self.rawValue
    }
    case motion1
    case motion2
    case motion3
    
    static public func ==(lhs: LegMotion, rhs: LegMotion) -> Bool{
        return lhs.motionName == rhs.motionName
    }
}

public enum BackMotion: String, PartMotion{
    
    public var part: BodyPart {
        return .back
    }
    
    public var motionName: String {
        return self.rawValue
    }
    
    case motion1
    case motion2
    case motion3
    
    static public func ==(lhs: BackMotion, rhs: BackMotion) -> Bool{
        return lhs.motionName == rhs.motionName
    }
}

public enum ShoulderMotion: String, PartMotion, Equatable{
    public var part: BodyPart {
        return .shoulder
    }
    
    public var motionName: String {
        return self.rawValue
    }
    
    case motion1
    case motion2
    case motion3
    
    static public func ==(lhs: ShoulderMotion, rhs: ShoulderMotion) -> Bool{
        return lhs.motionName == rhs.motionName
    }
}

public protocol PartMotion{
    var part: BodyPart { get }
    var motionName: String { get }
}

class Motion: NSObject, NSCoding {
    var name: String = ""
    var motionType: PartMotion
    var date: Date = Date()
    var weight: Float
    var repeats: UInt
    var timeConsuming: UInt
    
    var exerciseConsuming: Float {
        return weight * Float(repeats)
    }
    
    init(weight: Float, repeats: UInt, timeConsuming: UInt, motionType: PartMotion) {
        self.weight = weight
        self.repeats = repeats
        self.timeConsuming = timeConsuming
        self.motionType = motionType
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        motionType = aDecoder.decodeObject(forKey: "motionType") as! PartMotion
        date = aDecoder.decodeObject(forKey: "date") as! Date
        weight = aDecoder.decodeObject(forKey: "weight") as! Float
        repeats = aDecoder.decodeObject(forKey: "repeats") as! UInt
        timeConsuming = aDecoder.decodeObject(forKey: "timeConsuming") as! UInt
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(motionType, forKey: "motionType")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(weight, forKey: "weight")
        aCoder.encode(repeats, forKey: "repeats")
        aCoder.encode(timeConsuming, forKey: "timingConsuming")
    }
    
    
//    static func ==(lhs: Motion, rhs: Motion) -> Bool{
//        return lhs.motionType == rhs.motionType
//    }
}



class Training: NSObject {
    var motions = [Motion]()
    var motionType: PartMotion
    var numberOfGroup: UInt = 0
    var totalTimeConsuming: UInt = 0
    var totalExerciseConsuming: Float = 0
    var maxWeight: Float = 0
    var averageWight: Float = 0
    var date: Date = Date()
    var totoalWeight: Float = 0
    
    init(motionType: PartMotion) {
        self.motionType = motionType
    }
    
    func addMotion(motion: Motion) {
        self.motions.append(motion)
        self.numberOfGroup += 1
        self.totalTimeConsuming += motion.timeConsuming
        self.totalExerciseConsuming += motion.exerciseConsuming
        self.totoalWeight += motion.weight
        self.averageWight = self.totoalWeight / Float(self.motions.count)
        
        if self.maxWeight == 0 {
            self.maxWeight = motion.weight
        }
        if self.maxWeight < motion.weight {
            self.maxWeight = motion.weight
        }
    }
}




