//
//  GloabalDefine.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/13.
//  Copyright © 2016年 George. All rights reserved.
//

import Foundation
import UIKit

public let SCREEN_WIDTH: Double = Double(UIScreen.main.bounds.size.width)
public let SCREEN_HEIGHT: Double = Double(UIScreen.main.bounds.size.height)
public let CHOOSE_ITEM_PADDING: Double = 20.5
public let CHOOSE_ITEM_HORIZONTAL_SPACING: Double = 11.0

public let ALL_BODY_PART_CHOICES: [BodyPart] = [.leg, .shoulder, .back]
public let ALL_BACK_MOTION_CHOICES: [BackMotion] = [.motion1, .motion2, .motion3]
public let ALL_LEG_MOTION_CHOICES: [LegMotion] = [.motion1, .motion2, .motion3]
public let ALL_SHOULDER_MOTION_CHOICES: [ShoulderMotion] = [.motion1, .motion2, .motion3]


public let KEY_USER_CHOSEN_PARTS = "USER_CHOSEN_PARTS"
public let KEY_USER_CHOSEN_BACK_MOTIONS = "KEY_USER_CHOSEN_BACK_MOTIONS"
public let KEY_USER_CHOSEN_LEG_MOTIONS = "KEY_USER_CHOSEN_LEG_MOTIONS"
public let KEY_USER_CHOSEN_SHOULDER_MOTIONS = "KEY_USER_CHOSEN_SHOULDER_MOTIONS"

public let USER_CHOSEN_PARTS: [BodyPart] = {
    if let tmp = UserDefaults.standard.object(forKey: KEY_USER_CHOSEN_PARTS){
        return UserDefaults.standard.object(forKey: KEY_USER_CHOSEN_PARTS) as! [BodyPart]
    }
    return [ALL_BODY_PART_CHOICES.first!]
}()

public let USER_CHOSEN_BACK_MOTION: [BackMotion] = {
    if let tmp = UserDefaults.standard.object(forKey: KEY_USER_CHOSEN_BACK_MOTIONS){
        return UserDefaults.standard.object(forKey: KEY_USER_CHOSEN_BACK_MOTIONS) as! [BackMotion]
    }
    return [ALL_BACK_MOTION_CHOICES.first!]
}()

public let USER_CHOSEN_LEG_MOTION: [LegMotion] = {
    if let tmp = UserDefaults.standard.object(forKey: KEY_USER_CHOSEN_LEG_MOTIONS){
        return UserDefaults.standard.object(forKey: KEY_USER_CHOSEN_LEG_MOTIONS) as! [LegMotion]
    }
    return [ALL_LEG_MOTION_CHOICES.first!]
}()

public let USER_CHOSEN_SHOULDER_MOTION: [ShoulderMotion] = {
    if let tmp = UserDefaults.standard.object(forKey: KEY_USER_CHOSEN_SHOULDER_MOTIONS){
        return UserDefaults.standard.object(forKey: KEY_USER_CHOSEN_SHOULDER_MOTIONS) as! [ShoulderMotion]
    }
    return [ALL_SHOULDER_MOTION_CHOICES.first!]
}()








