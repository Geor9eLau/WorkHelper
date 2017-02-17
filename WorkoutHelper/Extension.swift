//
//  Extension.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/15.
//  Copyright © 2016年 George. All rights reserved.
//

import Foundation

//http://stackoverflow.com/questions/34364344/extend-array-constrained-when-element-is-a-tuple
extension Sequence where Iterator.Element == BodyPart{
    func getSelectableParts(chosenParts: [BodyPart]) -> [BodyPart] {
        var tmpParts = [BodyPart]()
        var isSame: Bool
        for part in self {
            isSame = false
            for chosenPart in chosenParts {
                if part == chosenPart{
                    isSame = true
                    break
                }
            }
            if isSame == false{
                tmpParts.append(part)
            }
        }
        return tmpParts
    }
}

extension Array where Element: PartMotion{
    func getSelectableMotions(chosenMotions: [PartMotion]) -> [PartMotion] {
        var tmpMotions = [PartMotion]()
        var isSame: Bool
        for motion in self {
            isSame = false
            for chosenMotion in chosenMotions {
                if motion.motionName == chosenMotion.motionName{
                    isSame = true
                    break
                }
            }
            if isSame == false{
                tmpMotions.append(motion)
            }
        }
    
        return tmpMotions
    }
}


protocol NSCodableEnum {
    func int() -> Int
    init?(rawValue:Int)
    init(defaultValue:Any)
}

extension NSCoder {
    func encodeBodyParts(parts: [BodyPart], forKey:String) {
        var tmpData = [String]()
        for part in parts {
            tmpData.append(part.rawValue)
        }
        self.encode(tmpData, forKey: forKey)
    }
    
    func decodeBodyPart(forKey:String) -> [BodyPart] {
        var tmpData = [BodyPart]()
        if let partsStr = self.decodeObject(forKey: forKey) as? [String] {
            for partStr in partsStr {
                tmpData.append(BodyPart(rawValue: partStr)!)
            }
        }
        return tmpData
    }
    
    func encodeQuadricepsMotions(motions: [QuadricepsMotion], forKey:String) {
        var tmpData = [String]()
        for motion in motions {
            tmpData.append(motion.rawValue)
        }
        self.encode(tmpData, forKey: forKey)
    }
    
    func decodeQuadricepsMotions(forKey:String) -> [QuadricepsMotion] {
        var tmpData = [QuadricepsMotion]()
        if let motionsStr = self.decodeObject(forKey: forKey) as? [String] {
            for motionStr in motionsStr {
                tmpData.append(QuadricepsMotion(rawValue: motionStr)!)
            }
        }
        return tmpData
    }
    
    func encodeBackMotions(motions: [BackMotion], forKey:String) {
        var tmpData = [String]()
        for motion in motions {
            tmpData.append(motion.rawValue)
        }
        self.encode(tmpData, forKey: forKey)
    }
    
    func decodeBackMotions(forKey:String) -> [BackMotion] {
        var tmpData = [BackMotion]()
        if let motionsStr = self.decodeObject(forKey: forKey) as? [String] {
            for motionStr in motionsStr {
                tmpData.append(BackMotion(rawValue: motionStr)!)
            }
        }
        return tmpData
    }
    
    func encodeShoulderMotions(motions: [ShoulderMotion], forKey:String) {
        var tmpData = [String]()
        for motion in motions {
            tmpData.append(motion.rawValue)
        }
        self.encode(tmpData, forKey: forKey)
    }
    
    func decodeShoulderMotions(forKey:String) -> [ShoulderMotion] {
        var tmpData = [ShoulderMotion]()
        if let motionsStr = self.decodeObject(forKey: forKey) as? [String] {
            for motionStr in motionsStr {
                tmpData.append(ShoulderMotion(rawValue: motionStr)!)
            }
        }
        return tmpData
    }
    
    func encodeChestMotions(motions: [ChestMotion], forKey:String) {
        var tmpData = [String]()
        for motion in motions {
            tmpData.append(motion.rawValue)
        }
        self.encode(tmpData, forKey: forKey)
    }
    
    func decodeChestMotions(forKey:String) -> [ChestMotion] {
        var tmpData = [ChestMotion]()
        if let motionsStr = self.decodeObject(forKey: forKey) as? [String] {
            for motionStr in motionsStr {
                tmpData.append(ChestMotion(rawValue: motionStr)!)
            }
        }
        return tmpData
    }
    
    func encodeAbsMotions(motions: [AbsMotion], forKey:String) {
        var tmpData = [String]()
        for motion in motions {
            tmpData.append(motion.rawValue)
        }
        self.encode(tmpData, forKey: forKey)
    }
    
    func decodeAbsMotions(forKey:String) -> [AbsMotion] {
        var tmpData = [AbsMotion]()
        if let motionsStr = self.decodeObject(forKey: forKey) as? [String] {
            for motionStr in motionsStr {
                tmpData.append(AbsMotion(rawValue: motionStr)!)
            }
        }
        return tmpData
    }
    
    func encodePartMotion(partMotion: PartMotion, forkey:String){
        let tmpStrArr = [partMotion.part.rawValue, partMotion.motionName]
        self.encode(tmpStrArr, forKey: forkey)
    }
    
    func decodePartMotion(forKey:String) -> PartMotion? {
        if let tmpStrArr = self.decodeObject(forKey: forKey) as? [String]{
            let partName = tmpStrArr.first
            let motionName = tmpStrArr.last
            let part = BodyPart(rawValue: partName!)
            switch part! {
            case .back:
                let backMotion = BackMotion(rawValue: motionName!)
                return backMotion
            case .quadriceps:
                let quadricepsMotion = QuadricepsMotion(rawValue: motionName!)
                return quadricepsMotion
            case .shoulder:
                let shoulderMotion = ShoulderMotion(rawValue: motionName!)
                return shoulderMotion
            case .abs:
                let absMotion = AbsMotion(rawValue: motionName!)
                return absMotion
            case .chest:
                let chestMotion = ChestMotion(rawValue: motionName!)
                return chestMotion
            }
        }
        return nil
    }
}



