//
//  ScrollableChartView.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/16.
//  Copyright © 2017年 George. All rights reserved.
//

import UIKit

class ScrollableChartView: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var chartView: PNBarChart
    override init(frame: CGRect) {
        chartView = PNBarChart(frame: CGRect(origin: CGPoint.zero, size: frame.size))
        chartView.backgroundColor = UIColor.clear
        chartView.animationType = .Waterfall
        chartView.labelMarginTop = 5.0
        
        super.init(frame: frame)
        addSubview(chartView)
        contentSize = chartView.frame.size
    }
    
//    init(frame: CGRect, xLabels: [String], yValues: [CGFloat]) {
//        
//        chartView = PNBarChart(frame: CGRect(origin: CGPoint.zero, size: frame.size))
//        chartView.xLabels = xLabels
//        chartView.yValues = yValues
//        chartView.backgroundColor = UIColor.clear
//        chartView.animationType = .Waterfall
//        chartView.labelMarginTop = 5.0
//        chartView.strokeChart()
//        
//        super.init(frame: frame)
//        addSubview(chartView)
//        contentSize = chartView.frame.size
//    }
//    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(xLabels: [String], yValues: [CGFloat]) {
        guard xLabels.count > 0 && yValues.count > 0 else {
            return
        }
        chartView.xLabels = xLabels
        chartView.yValues = yValues
        chartView.strokeChart()
    }
    
}
