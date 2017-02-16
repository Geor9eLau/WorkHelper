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
    private let trainingId = Expression<String>("trainingId")
    private let motions = Expression<Blob>("motions")
    private let numberOfGroup = Expression<Int64>("numberOfGroup")
    private let totalTimeConsuming = Expression<Int64>("totalTimeConsuming")
    private let totalRepeats = Expression<Int64>("totalRepeats")
//    private let totalExerciseConsuming = Expression<Double>("totalExerciseConsuming")
    private let maxWeight = Expression<Double>("maxWeight")
    private let averageWeight = Expression<Double>("averageWeight")
//    private let totalWeight = Expression<Double>("totalWeight")

    // MARK: - Record
    private let recordTable = Table("Record")
    
    
    
    // MARK: - 
    // MARK: -
    private func addTrainingRecord(training: Training) {
        do{
            let dateMatter = DateFormatter()
            dateMatter.dateFormat = "yyyy-MM-dd"
            let dateStr = dateMatter.string(from: training.date)
            let motionsData = NSKeyedArchiver.archivedData(withRootObject: training.motions)
            try dataBase?.run(trainingTable.insert(or: .replace,numberOfGroup <- Int64(training.numberOfGroup),
                                                   totalTimeConsuming <- Int64(training.totalTimeConsuming),
                                                   trainingId <- training.trainingId,
                                                   averageWeight <- Double(training.averageWeight),
                                                   maxWeight <- Double(training.maxWeight), totalRepeats <- Int64(training.totoalRepeats),
                                                   date <- dateStr,
                                                   motionTypeName <- training.motionType.motionName,
                                                   motionTypePart <- training.motionType.part.rawValue,
                                                   motions <- motionsData.datatypeValue
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
    
    func updateRecord(training: Training) {
        self.addTrainingRecord(training: training)
        
        let record = Record(motion: training.motionType)
        record.maxWeight = training.maxWeight
        record.totalRepeats = training.totoalRepeats
        record.totalTimeConsuming = training.totalTimeConsuming
        
        if let oldRecord = self.getRecord(motion: training.motionType){
            if oldRecord.maxWeight > record.maxWeight{
                record.maxWeight = oldRecord.maxWeight
            }
            record.totalRepeats = record.totalRepeats + oldRecord.totalRepeats
            record.totalTimeConsuming = record.totalTimeConsuming + oldRecord.totalTimeConsuming
        }
        
        do{
            try dataBase?.run(recordTable.insert(or: .replace, motionTypeName <- record.motion.motionName, motionTypePart <- record.motion.part.rawValue, maxWeight <- record.maxWeight, totalRepeats <- Int64(record.totalRepeats), totalTimeConsuming <- Int64(record.totalTimeConsuming)))
        }catch let error{
            print("\(error)")
        }
        
    }
    
    func getRecord(motion: PartMotion) -> Record?{
        do{
            if let tmpRecordArr = try dataBase?.prepare(recordTable.filter(motionTypeName == motion.motionName && motionTypePart == motion.part.rawValue)){
                for recordDic in tmpRecordArr{
                    let partName = recordDic.get(motionTypePart)
                    let motionName = recordDic.get(motionTypeName)
                    var motion: PartMotion
                    let part = BodyPart(rawValue: partName)!
                    switch part {
                    case .back:
                        motion = BackMotion(rawValue: motionName)!
                    case .leg:
                        motion = LegMotion(rawValue: motionName)!
                    case .shoulder:
                        motion = ShoulderMotion(rawValue: motionName)!
                    }
                    
                    let record = Record(motion: motion)
                    record.maxWeight = recordDic.get(maxWeight)
                    record.totalRepeats = UInt(recordDic.get(totalRepeats))
                    record.totalTimeConsuming = UInt(recordDic.get(totalTimeConsuming))
                    
                    return record
                }
            }
        } catch let error{
            print("\(error)")
        }
        return nil
    }
    
    
    func getTrainingRecord(motion: PartMotion, trainingDate: Date) -> Training? {
        do{
            if let tmpTrainingArr = try dataBase?.prepare(trainingTable.filter(motionTypeName == motion.motionName && motionTypePart == motion.part.rawValue && date == Util.transformDateToDateStr(date: trainingDate))){
                for trainingDic in tmpTrainingArr {
                    let id = trainingDic.get(trainingId)
                    let motionsData = trainingDic.get(motions).bytes
                    let motionsArr = NSKeyedUnarchiver.unarchiveObject(with: Data(bytes: motionsData)) as? [Motion]
                    let training = Training(motionType: motion, trainingId: id)
                    training.motions = motionsArr!
                    return training
                }
            }
            
        }catch let error{
            print("\(error)")
        }
        return nil
    }
    
    
    func getRecordDescription(part: BodyPart) -> String {
        var recordDecp = "You've finished: \n"
        do {
            if let recordsArr = try dataBase?.prepare(recordTable.select(motionTypeName, totalRepeats).filter(motionTypePart == part.rawValue)){
                
                for record in recordsArr{
//                    let attributedStr = NSAttributedString(string: "\(record.get(totalRepeats)) \(record.get(motionTypeName))", attributes: [n])
                    recordDecp.append("\(record.get(totalRepeats)) \(record.get(motionTypeName)) \n")
                }
                if recordDecp.characters.count > "You've finished ".characters.count{
                    return recordDecp
                }else{
                    return "Have no record~"
                }
            }
        }catch let error{
            print("\(error)")
        }
        return "Have no record~"
    }
    
    
    func getAllTrainingRecord(motion: PartMotion) -> [Training] {
        var result = [Training]()
        do{
            if let tmp = try dataBase?.prepare(trainingTable.filter(motionTypeName == motion.motionName && motionTypePart == motion.part.rawValue)){
                for row in tmp {
                    let id = row.get(trainingId)
                    let motionsData = row.get(motions).bytes
                    let motionsArr = NSKeyedUnarchiver.unarchiveObject(with: Data(bytes: motionsData)) as? [Motion]
                    let training = Training(motionType: motion, trainingId: id)
                    training.motions = motionsArr!
                    result.append(training)
                }
            }
        } catch let error{
            print("\(error)")
        }
        return result
    }
    
    
    
    // MARK: - computed property
//    private var isFirstTime: Bool {
//        return UserDefaults.standard.bool(forKey: "isFirstTime")
//    }
    
    
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
            try dataBase?.run(motionTable.create(ifNotExists: true) { t in
                t.column(motionId, primaryKey: true)
//                t.column(name)
                t.column(motionTypeName)
                t.column(motionTypePart)
                t.column(date)
                t.column(weight)
                t.column(repeats)
                t.column(timingConsuming)
            })
            
            try dataBase?.run(trainingTable.create(ifNotExists: true) { t in
                t.column(trainingId, primaryKey: true)
                t.column(motions)
                t.column(numberOfGroup)
                t.column(motionTypeName)
                t.column(motionTypePart)
                t.column(date)
                t.column(totalTimeConsuming)
                t.column(maxWeight)
                t.column(totalRepeats)
                t.column(averageWeight)
            })
            
            try dataBase?.run(recordTable.create(ifNotExists: true) { t in
                t.column(motionTypeName, primaryKey: true)
                t.column(motionTypePart)
                t.column(totalTimeConsuming)
                t.column(maxWeight)
                t.column(totalRepeats)
            })
        }
        catch let error{
            print("\(error)")
        }
    }
    
}






