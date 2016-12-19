//
//  CustomChooseView.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/13.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit

enum ChooseViewType: ChooseViewTypeProtocol {
    
    var choices: [Any] {
        switch self{
        case .part:
            return ALL_BODY_PART_CHOICES.getSelectableParts(chosenParts: DataManager.userChosenParts)
        case let .motion(partType):
            switch partType {
            case .leg:
                return ALL_LEG_MOTION_CHOICES.getSelectableMotions(chosenMotions: DataManager.userChosenLegMotions)
            case .back:
                return ALL_BACK_MOTION_CHOICES.getSelectableMotions(chosenMotions: DataManager.userChosenBackMotions)
            case .shoulder:
                return ALL_SHOULDER_MOTION_CHOICES.getSelectableMotions(chosenMotions: DataManager.userChosenShoulderMotions)
            }
        case let .repeats(motionType):
            switch motionType.part {
            case .leg:
                switch motionType.motionName {
                case "motion1":
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                default:
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                }
                
            case .back:
                switch motionType.motionName {
                case "motion1":
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                default:
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                }
                
            case .shoulder:
                switch motionType.motionName {
                case "motion1":
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                default:
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                }
            }
            
        case let .weight(motionType):
            switch motionType.part {
            case .leg:
                switch motionType.motionName {
                case "motion1":
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                default:
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                }
                
            case .back:
                switch motionType.motionName {
                case "motion1":
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                default:
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                }
                
            case .shoulder:
                switch motionType.motionName {
                case "motion1":
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                default:
                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
                }
            }
        }
    }

//    var choicesForPart: [BodyPart]? {
//        switch self{
//            case .part:
//            return ALL_BODY_PART_CHOICES.getSelectableParts(chosenParts: USER_CHOSEN_PARTS)
//            default:
//            return nil
//        }
//    }
//
//    var choicesForMotion: [PartMotion]? {
//        switch self {
//        case let .motion(partType):
//            switch partType {
//            case .leg:
//                return ALL_LEG_MOTION_CHOICES.getSelectableMotions(chosenMotions: USER_CHOSEN_LEG_MOTION)
//            case .back:
//                return ALL_BACK_MOTION_CHOICES.getSelectableMotions(chosenMotions: USER_CHOSEN_BACK_MOTION)
//            case .shoulder:
//                return ALL_SHOULDER_MOTION_CHOICES.getSelectableMotions(chosenMotions: USER_CHOSEN_SHOULDER_MOTION)
//            }
//        default:
//            return nil
//        }
//    }
//    var choices: [String] {
//        var tmp = [String]()
//        switch self {
//        case .part:
//            for part in ALL_BODY_PART_CHOICES {
//                tmp.append(part.rawValue)
//            }
//            return tmp
//            
//        case let .motion(bodyType):
//            switch bodyType {
//            case .leg:
//                for part in ALL_LEG_MOTION_CHOICES {
//                    tmp.append(part.rawValue)
//                }
//                return tmp
//            case .back:
//                for part in ALL_BACK_MOTION_CHOICES {
//                    tmp.append(part.rawValue)
//                }
//                return tmp
//            case .shoulder:
//                for part in ALL_SHOULDER_MOTION_CHOICES {
//                    tmp.append(part.rawValue)
//                }
//                return tmp
//            }
//            
//        case let .repeats(motionType):
//            switch motionType.type {
//            case .leg:
//                switch motionType.motionName {
//                case "motion1":
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                default:
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                }
//                
//            case .back:
//                switch motionType.motionName {
//                case "motion1":
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                default:
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                }
//                
//            case .shoulder:
//                switch motionType.motionName {
//                case "motion1":
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                default:
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                }
//            }
//            
//        case let .weight(motionType):
//            switch motionType.type {
//            case .leg:
//                switch motionType.motionName {
//                case "motion1":
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                default:
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                }
//                
//            case .back:
//                switch motionType.motionName {
//                case "motion1":
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                default:
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                }
//                
//            case .shoulder:
//                switch motionType.motionName {
//                case "motion1":
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                default:
//                    return ["2", "4", "6", "8", "10", "12", "14", "16", "18" ]
//                }
//            }
//        }
//    }
    
    case part
    case motion(partType: BodyPart)
    case repeats(motionType: PartMotion)
    case weight(motionType: PartMotion)
}


protocol ChooseViewTypeProtocol {
    var choices: [Any] { get }
//    var choicesForPart: [BodyPart]? { get }
//    var choicesForMotion: [PartMotion]? { get }
}


protocol CustomChooseViewDelegate: NSObjectProtocol {
    func choose(item: Any)
}

class CustomChooseView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var type: ChooseViewType
    weak var delegate: CustomChooseViewDelegate?
    private lazy var dataSource: [Any] = {
        return self.type.choices
    }()
//    private lazy var choices: [String] = {
//        return self.type.choices
//    }()
    private lazy var colltectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.itemWidth, height: self.itemWidth)
        layout.minimumLineSpacing = 5.0;
        let tmpCollectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH , height: SCREEN_HEIGHT - 200), collectionViewLayout: layout)
        tmpCollectionView.delegate = self
        tmpCollectionView.dataSource = self
        tmpCollectionView.register(UINib.init(nibName: "ChooseCollectionCell", bundle: nil), forCellWithReuseIdentifier: "chooseCell")
        tmpCollectionView.collectionViewLayout = layout
        tmpCollectionView.backgroundColor = UIColor.clear
        return tmpCollectionView
    }()
    
    
    private var itemWidth: Double {
        return (SCREEN_WIDTH - CHOOSE_ITEM_PADDING * 2) / 3
    }
    
    
    // MARK: - Initialize
    
    init(_ frame: CGRect, type: ChooseViewType) {
        self.type = type
        super.init(frame: frame)
        backgroundColor = Util.RGBColor(r: 0, g: 0, b: 0, a: 0.56)
        self.addSubview(self.colltectionView)
        self.colltectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionDataSource
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chooseCell", for: indexPath) as! ChooseCollectionCell
        var cellLblStr: String
        let cellData = dataSource[indexPath.row]
        switch type {
        case .motion:
            cellLblStr = (cellData as! PartMotion).motionName
        case .part:
            cellLblStr = (cellData as! BodyPart).rawValue
        default:
            cellLblStr = cellData as! String
        }
        cell.chooseLbl.text = cellLblStr
        return cell
    }
    
    // MARK - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)
        guard (delegate != nil) else {return}
        delegate?.choose(item: item)
        self.removeFromSuperview()
        dataSource.remove(at: indexPath.row)
        colltectionView.reloadData()
    }
    
}
