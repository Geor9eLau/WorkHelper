//
//  CarouselItemView.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/16.
//  Copyright © 2017年 George. All rights reserved.
//

import UIKit

class CarouselItemView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var imgView: UIImageView
    var titleLbl: UILabel
    
    override init(frame: CGRect) {
        imgView = UIImageView(frame: CGRect(x: (frame.size.width - 100) / 2, y: (frame.size.height * 0.85 - 100) / 2, width: 100, height: 100))
        titleLbl = UILabel(frame: CGRect(x: 0, y: frame.size.height * 0.85, width: frame.size.width, height: frame.size.height * 0.15))
        titleLbl.font = UIFont.systemFont(ofSize: 20)
        titleLbl.textAlignment = .center
        
        super.init(frame: frame)
        addSubview(imgView)
        addSubview(titleLbl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
