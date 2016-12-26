//
//  DataManager.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/19.
//  Copyright © 2016年 George. All rights reserved.
//

import Foundation

public let ALL_BODY_PART_CHOICES: [BodyPart] = [.leg, .shoulder, .back]
public let ALL_BACK_MOTION_CHOICES: [BackMotion] = [.motion1, .motion2, .motion3]
public let ALL_LEG_MOTION_CHOICES: [LegMotion] = [.motion1, .motion2, .motion3]
public let ALL_SHOULDER_MOTION_CHOICES: [ShoulderMotion] = [.motion1, .motion2, .motion3]


fileprivate let KEY_USER_CHOSEN_PARTS = "USER_CHOSEN_PARTS"
fileprivate let KEY_USER_CHOSEN_BACK_MOTIONS = "KEY_USER_CHOSEN_BACK_MOTIONS"
fileprivate let KEY_USER_CHOSEN_LEG_MOTIONS = "KEY_USER_CHOSEN_LEG_MOTIONS"
fileprivate let KEY_USER_CHOSEN_SHOULDER_MOTIONS = "KEY_USER_CHOSEN_SHOULDER_MOTIONS"

public class DataManager: NSObject {
    static var userChosenParts: [BodyPart] {
        if let chosenPartsData = UserDefaults.standard.data(forKey: KEY_USER_CHOSEN_PARTS){
            let storer = NSKeyedUnarchiver.unarchiveObject(with: chosenPartsData) as! chosenPartsStorer
            return storer.chosenParts
        }
        return [BodyPart]()
    }
    
    static var userChosenLegMotions: [LegMotion] {
        if let chosenMotionData = UserDefaults.standard.data(forKey: KEY_USER_CHOSEN_LEG_MOTIONS){
            let storer = NSKeyedUnarchiver.unarchiveObject(with: chosenMotionData) as! chosenLegMotionsStorer
            return storer.chosenLegMotions
        }
        return [LegMotion]()
    }
    
    static var userChosenBackMotions: [BackMotion] {
        if let chosenMotionData = UserDefaults.standard.data(forKey: KEY_USER_CHOSEN_BACK_MOTIONS){
            let storer = NSKeyedUnarchiver.unarchiveObject(with: chosenMotionData) as! chosenBackMotionsStorer
            return storer.chosenBackMotions
        }
        return [BackMotion]()
    }
    
    static var userChosenShoulderMotions: [ShoulderMotion] {
        if let chosenMotionData = UserDefaults.standard.data(forKey: KEY_USER_CHOSEN_SHOULDER_MOTIONS){
            let storer = NSKeyedUnarchiver.unarchiveObject(with: chosenMotionData) as! chosenShoulderMotionsStorer
            return storer.chosenShoulderMotions
        }
        return [ShoulderMotion]()
    }
    
    static func updateChosenParts(chosenParts: [BodyPart]){
        let tmpStorer = chosenPartsStorer(chosenParts: chosenParts)
        let storedData = NSKeyedArchiver.archivedData(withRootObject: tmpStorer)
        UserDefaults.standard.set(storedData, forKey: KEY_USER_CHOSEN_PARTS)
        UserDefaults.standard.synchronize()
    }
    
    static func updateChosenMotion(chosenMotions: [PartMotion], part: BodyPart){
        
        switch part{
        case .back:
            let tmpStroer = chosenBackMotionsStorer(chosenMotions: chosenMotions as! [BackMotion])
            let storedData = NSKeyedArchiver.archivedData(withRootObject: tmpStroer)
            UserDefaults.standard.set(storedData, forKey: KEY_USER_CHOSEN_BACK_MOTIONS)
        case .leg:
            let tmpStroer = chosenLegMotionsStorer(chosenMotions: chosenMotions as! [LegMotion])
            let storedData = NSKeyedArchiver.archivedData(withRootObject: tmpStroer)
            UserDefaults.standard.set(storedData, forKey: KEY_USER_CHOSEN_LEG_MOTIONS)
        case .shoulder:
            let tmpStroer = chosenShoulderMotionsStorer(chosenMotions: chosenMotions as! [ShoulderMotion])
            let storedData = NSKeyedArchiver.archivedData(withRootObject: tmpStroer)
            UserDefaults.standard.set(storedData, forKey: KEY_USER_CHOSEN_SHOULDER_MOTIONS)
        }
        UserDefaults.standard.synchronize()
    }
    
    var isFirstTime: Bool {
        return UserDefaults.standard.bool(forKey: "isFirstTime")
    }
}

// TODO: - Storer Helper Class -


fileprivate class chosenPartsStorer: NSObject, NSCoding {
    var chosenParts: [BodyPart]
    
    init(chosenParts: [BodyPart]) {
        self.chosenParts = chosenParts
    }
    
    required init?(coder aDecoder: NSCoder) {
        chosenParts =  aDecoder.decodeBodyPart(forKey: "chosenParts")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encodeBodyParts(parts: chosenParts, forKey: "chosenParts")
    }
}

fileprivate class chosenLegMotionsStorer: NSObject, NSCoding {
    var chosenLegMotions: [LegMotion]
    
    init(chosenMotions: [LegMotion]) {
        self.chosenLegMotions = chosenMotions
    }
    
    required init?(coder aDecoder: NSCoder) {
        chosenLegMotions = aDecoder.decodeLegMotions(forKey: "chosenLegMotions")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encodeLegMotions(motions: chosenLegMotions, forKey: "chosenLegMotions")
    }
}

fileprivate class chosenBackMotionsStorer: NSObject, NSCoding {
    var chosenBackMotions: [BackMotion]
    
    init(chosenMotions: [BackMotion]) {
        self.chosenBackMotions = chosenMotions
    }
    
    required init?(coder aDecoder: NSCoder) {
        chosenBackMotions = aDecoder.decodeBackMotions(forKey: "chosenBackMotions")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encodeBackMotions(motions: chosenBackMotions, forKey: "chosenBackMotions")
    }
}

fileprivate class chosenShoulderMotionsStorer: NSObject, NSCoding {
    var chosenShoulderMotions: [ShoulderMotion]
    
    init(chosenMotions: [ShoulderMotion]) {
        self.chosenShoulderMotions = chosenMotions
    }
    
    required init?(coder aDecoder: NSCoder) {
        chosenShoulderMotions = aDecoder.decodeShoulderMotions(forKey: "chosenShoulderMotions")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encodeShoulderMotions(motions: chosenShoulderMotions, forKey: "chosenShoulderMotions")
    }
}



