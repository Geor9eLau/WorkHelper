//
//  Training.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/13.
//  Copyright © 2016年 George. All rights reserved.
//

import Foundation

public enum BodyPart: String {
    case chest = "Chest"
    case back = "Back"
    case shoulder = "Shoulder"
    case abs = "Abs"
    case quadriceps = "Quadriceps"
    static public func ==(lhs: BodyPart, rhs: BodyPart) -> Bool{
        return lhs.rawValue == rhs.rawValue
    }
}

public enum QuadricepsMotion: String, PartMotion{
    public var part: BodyPart {
        return .quadriceps
    }
    
    public var motionName: String {
        return self.rawValue
    }
    case motion1 = "BARBELL SQUAT"
    
    static public func ==(lhs: QuadricepsMotion, rhs: QuadricepsMotion) -> Bool{
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
    
    case motion1 = "MACHINE-ASSISTED PULL-UP"
    case motion2 = "BARBELL BENT-OVER Row"
    case motion3 = "SEATED CABLE ROWS"
    case moition4 = "PULL-DOWN"
    
    
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
    
    case motion1 = "FRONT RAISE"
    case motion2 = "LATERAL RAISE"
    case motion3 = "BACK FLYES"
    case motion4 = "CABLE SEATED LATERAL RAISE"
    
    static public func ==(lhs: ShoulderMotion, rhs: ShoulderMotion) -> Bool{
        return lhs.motionName == rhs.motionName
    }
}

public enum ChestMotion: String, PartMotion, Equatable{
    public var part: BodyPart {
        return .chest
    }
    
    public var motionName: String {
        return self.rawValue
    }
    
    case motion1 = "BARBELL BENCH PRESS"
    case motion2 = "BARBELL INCLINE BENCH PRESS"
    case motion3 = "BUTTERFLY"
    case motion4 = "CABLE CROSSOVER"
    
    static public func ==(lhs: ChestMotion, rhs: ChestMotion) -> Bool{
        return lhs.motionName == rhs.motionName
    }
}

public enum AbsMotion: String, PartMotion, Equatable{
    public var part: BodyPart {
        return .abs
    }
    
    public var motionName: String {
        return self.rawValue
    }
    
    case motion1 = "ALTERNATE HEEL TOUCHERS"
    case motion2 = "BOTTOMS UP"
    case motion3 = "SEATED LEG TUCKS"
    case motion4 = "TWIST"
    case motion5 = "George Way"
    
    static public func ==(lhs: AbsMotion, rhs: ChestMotion) -> Bool{
        return lhs.motionName == rhs.motionName
    }
}

public protocol PartMotion{
    var part: BodyPart { get }
    var motionName: String { get }
}

class Motion: NSObject, NSCoding {
    var motionId: String
//    var name: String = ""
    var motionType: PartMotion
    var date: Date = Date()
    var weight: Double
    var repeats: UInt
    var timeConsuming: UInt
    
//    var exerciseConsuming: Float {
//        
//        return weight * Float(repeats)
//    }
    
    init(motionId: String, weight: Double, repeats: UInt, timeConsuming: UInt, motionType: PartMotion) {
        self.motionId = motionId
        self.weight = weight
        self.repeats = repeats
        self.timeConsuming = timeConsuming
        self.motionType = motionType
    }
    
    required init?(coder aDecoder: NSCoder) {
//        name = aDecoder.decodeObject(forKey: "name") as! String
        motionId = aDecoder.decodeObject(forKey: "motionId") as! String
        motionType = aDecoder.decodePartMotion(forKey: "motionType")!
        date = aDecoder.decodeObject(forKey: "date") as! Date
        weight = aDecoder.decodeDouble(forKey: "weight")
        repeats = aDecoder.decodeObject(forKey: "repeats") as! UInt
        timeConsuming = aDecoder.decodeObject(forKey: "timeConsuming") as! UInt
    }
    
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
        aCoder.encode(motionId, forKey: "motionId")
        aCoder.encodePartMotion(partMotion: motionType, forkey: "motionType")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(weight, forKey: "weight")
        aCoder.encode(repeats, forKey: "repeats")
        aCoder.encode(timeConsuming, forKey: "timeConsuming")
    }
    
    
//    static func ==(lhs: Motion, rhs: Motion) -> Bool{
//        return lhs.motionType == rhs.motionType
//    }
}



class Training: NSObject {
    var trainingId: String
    var motions = [Motion]()
    var motionType: PartMotion
    var numberOfGroup: UInt{
        return UInt(self.motions.count)
    }
    var totalTimeConsuming: UInt{
        var tmpTC: UInt = 0
        for motion in self.motions{
            tmpTC = tmpTC + motion.timeConsuming
        }
        return tmpTC
    }
//    var totalExerciseConsuming: Float{
//        var tmpEC:  = 0
//        for motion in self.motions{
//            tmpEC = tmpEC + motion.weight * motion.weight
//        }
//        return tmpEC
//    }
    var maxWeight: Double{
        var tmpMax: Double = 0
        for motion in self.motions{
            if motion.weight > tmpMax{
                tmpMax = motion.weight
            }
        }
        return tmpMax
    }
    
    
    var averageWeight: Double{
        var tmpWeight: Double = 0
        for motion in self.motions{
            tmpWeight = tmpWeight + motion.weight
        }
        return tmpWeight
    }
    var date: Date = Date()
    var totoalRepeats: UInt{
        var tmpRepeats: UInt = 0
        for motion in self.motions{
            tmpRepeats = tmpRepeats + motion.repeats
        }
        return tmpRepeats
    }
    
    init(motionType: PartMotion, trainingId: String) {
        self.motionType = motionType
        self.trainingId = trainingId
    }
    
    func addMotion(motion: Motion) {
        self.motions.append(motion)
    }
}




