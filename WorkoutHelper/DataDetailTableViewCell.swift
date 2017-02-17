//
//  DataDetailTableViewCell.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/16.
//  Copyright © 2017年 George. All rights reserved.
//

import UIKit

enum DataDetailCellType: String{
    case weight
    case repeats
    case time
    case none
}

class DataDetailTableViewCell: UITableViewCell {

    var titleLbl: UILabel
    private var chartView: ScrollableChartView
    
    var type: DataDetailCellType = .none
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        titleLbl = UILabel(frame: CGRect(x: 20, y: 8, width: 200, height: 30))
        titleLbl.font = UIFont.systemFont(ofSize: 15)
        titleLbl.textColor = UIColor.black
        
        chartView = ScrollableChartView(frame: CGRect(x: 20, y: 40, width: SCREEN_WIDTH - 40, height: 160))
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLbl)
        addSubview(chartView)
    }
    
    func update(records: [Training]) {
        var tmpY = [CGFloat]()
        var tmpX = [String]()
        switch self.type {
        case .weight:
            for training in records{
                tmpY.append(CGFloat(training.maxWeight))
                let tmpDate = Util.transformDateToDateStr(date: training.date)
                let index = tmpDate.index(tmpDate.startIndex, offsetBy: 5)
                tmpX.append(tmpDate.substring(from: index))
            }
        case .repeats:
            for training in records{
                tmpY.append(CGFloat(training.totoalRepeats))
//                tmpX.append(Util.transformDateToDateStr(date: training.date))
                let tmpDate = Util.transformDateToDateStr(date: training.date)
                let index = tmpDate.index(tmpDate.startIndex, offsetBy: 5)
                tmpX.append(tmpDate.substring(from: index))
            }
        case .time:
            for training in records{
                tmpY.append(CGFloat(training.totalTimeConsuming))
//                tmpX.append(Util.transformDateToDateStr(date: training.date))
                let tmpDate = Util.transformDateToDateStr(date: training.date)
                let index = tmpDate.index(tmpDate.startIndex, offsetBy: 5)
                tmpX.append(tmpDate.substring(from: index))
            }
        default:
            return
        }
        
        chartView.setupData(xLabels: tmpX, yValues: tmpY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
