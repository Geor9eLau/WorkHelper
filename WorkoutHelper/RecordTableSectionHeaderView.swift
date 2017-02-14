//
//  RecordTableSectionHeaderView.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/14.
//  Copyright © 2017年 George. All rights reserved.
//

import UIKit

class RecordTableSectionHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var infoLblWidth: Double {
        return Double(self.frame.size.width - 50) / 3.0
    }
    
    private lazy var numberLbl: UILabel = {
       let tmp = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        tmp.text = "No"
        tmp.font = UIFont.systemFont(ofSize: 12)
        tmp.textAlignment = .center
        tmp.layer.borderColor = UIColor.black.cgColor
        tmp.layer.borderWidth = 1.0
        return tmp
    }()
    
    private lazy var weightLbl: UILabel = {
        let tmp = UILabel(frame: CGRect(x: 50, y: 0, width: self.infoLblWidth, height: 30))
        tmp.text = "Weight/kg"
        tmp.font = UIFont.systemFont(ofSize: 12)
        tmp.textAlignment = .center
        tmp.layer.borderColor = UIColor.black.cgColor
        tmp.layer.borderWidth = 1.0
        return tmp
    }()
    
    private lazy var repeatsLbl: UILabel = {
        let tmp = UILabel(frame: CGRect(x: 50 + self.infoLblWidth, y: 0, width: self.infoLblWidth, height: 30))
        tmp.text = "Repeats"
        tmp.font = UIFont.systemFont(ofSize: 12)
        tmp.textAlignment = .center
        tmp.layer.borderColor = UIColor.black.cgColor
        tmp.layer.borderWidth = 1.0
        return tmp
    }()

    private lazy var timeLbl: UILabel = {
        let tmp = UILabel(frame: CGRect(x: 50 + self.infoLblWidth * 2, y: 0, width: self.infoLblWidth, height: 30))
        tmp.text = "Time/s"
        tmp.font = UIFont.systemFont(ofSize: 12)
        tmp.textAlignment = .center
        tmp.layer.borderColor = UIColor.black.cgColor
        tmp.layer.borderWidth = 1.0
        return tmp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(numberLbl)
        addSubview(weightLbl)
        addSubview(repeatsLbl)
        addSubview(timeLbl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
