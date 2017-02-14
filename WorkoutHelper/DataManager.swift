//
//  DataManager.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/19.
//  Copyright © 2016年 George. All rights reserved.
//

import Foundation
import SQLite

public let ALL_BODY_PART_CHOICES: [BodyPart] = [.leg, .shoulder, .back]
public let ALL_BACK_MOTION_CHOICES: [BackMotion] = [.motion1, .motion2, .motion3]
public let ALL_LEG_MOTION_CHOICES: [LegMotion] = [.motion1, .motion2, .motion3]
public let ALL_SHOULDER_MOTION_CHOICES: [ShoulderMotion] = [.motion1, .motion2, .motion3]


fileprivate let KEY_USER_CHOSEN_PARTS = "USER_CHOSEN_PARTS"
fileprivate let KEY_USER_CHOSEN_BACK_MOTIONS = "KEY_USER_CHOSEN_BACK_MOTIONS"
fileprivate let KEY_USER_CHOSEN_LEG_MOTIONS = "KEY_USER_CHOSEN_LEG_MOTIONS"
fileprivate let KEY_USER_CHOSEN_SHOULDER_MOTIONS = "KEY_USER_CHOSEN_SHOULDER_MOTIONS"

public class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    private var dataBase: Connection?
        
    // MARK: - Motion
    private let motionTable = Table("Motion")
    private let motionId = Expression<String>("motionId")
//    private let name = Expression<String>("name")
    private let motionTypeName = Expression<String>("motionTypeName")
    private let motionTypePart = Expression<String>("motionTypePart")
    private let date = Expression<String>("date")
    private let weight = Expression<Double>("weight")
    private let repeats = Expression<Int64>("repeats")
    private let timingConsuming = Expression<Int64>("timingConsuming")
    
    // MARK: - Training
    private let trainingTable = Table("Training")
    private let motions = Expression<Blob>("motions")
    private let numberOfGroup = Expression<Int64>("numberOfGroup")
    private let totalTimeConsuming = Expression<Int64>("totalTimeConsuming")
    private let totalExerciseConsuming = Expression<Double>("totalExerciseConsuming")
    private let maxWeight = Expression<Double>("maxWeight")
    private let averageWeight = Expression<Double>("averageWeight")
    private let totalWeight = Expression<Double>("totalWeight")
    
    
    
    
    // MARK: -
    func addTrainingRecord(training: Training) {
        do{
            let dateMatter = DateFormatter()
            dateMatter.dateFormat = "yyyy-MM-dd"
            let dateStr = dateMatter.string(from: training.date)
            
            let motionsData = NSKeyedArchiver.archivedData(withRootObject: training.motions)
            try dataBase?.run(trainingTable.insert(numberOfGroup <- Int64(training.numberOfGroup),
                                                   totalTimeConsuming <- Int64(training.totalTimeConsuming),
                                                   totalExerciseConsuming <- Double(training.totalExerciseConsuming),
                                                   averageWeight <- Double(training.averageWeight),
                                                   maxWeight <- Double(training.maxWeight), totalWeight <- Double(training.totoalWeight),
                                                   date <- dateStr,
                                                   motionTypeName <- training.motionType.motionName,
                                                   motionTypePart <- training.motionType.part.rawValue,
                                                   motions <- motionsData.datatypeValue,
                                                   totalWeight <- Double(training.totoalWeight)
                                                   ))
        }
        catch let error{
            print("\(error)")
        }
    }
    
    
    func addMotionRecord(motion: Motion){
        do{
            try dataBase?.run(motionTable.insert(motionId <- motion.motionId,
                                                 repeats <- Int64(motion.repeats),
                                                   timingConsuming <- Int64(motion.timeConsuming),
                                                   date <- Util.transformDateToDateStr(date: motion.date),
                                                   motionTypeName <- motion.motionType.motionName,
                                                   motionTypePart <- motion.motionType.part.rawValue,
                                                   weight <- Double(motion.weight)
            ))
        }
        catch let error{
            print("\(error)")
        }
    }
    
    
    
    // MARK: - computed property
    private var isFirstTime: Bool {
        return UserDefaults.standard.bool(forKey: "isFirstTime")
    }
    
    
    // MARK: - used to build singleton
    private override init() {
        super.init()
        do{
            dataBase = try Connection("\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!)/db.sqlite3")
        }
        catch let error{
            print("\(error)")
        }
        
        
        do {
            try dataBase?.run(motionTable.create { t in
                t.column(motionId)
//                t.column(name)
                t.column(motionTypeName)
                t.column(motionTypePart)
                t.column(date)
                t.column(weight)
                t.column(repeats)
                t.column(timingConsuming)
            })
            
            try dataBase?.run(trainingTable.create { t in
                t.column(numberOfGroup)
                t.column(motionTypeName)
                t.column(motionTypePart)
                t.column(date)
                t.column(totalTimeConsuming)
                t.column(maxWeight)
                t.column(totalWeight)
                t.column(averageWeight)
                t.column(totalExerciseConsuming)
            })
        }
        catch let error{
            print("\(error)")
        }
    }
    
}






