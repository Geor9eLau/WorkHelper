//
//  ChooseCollectionCell.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/14.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit

class ChooseCollectionCell: UICollectionViewCell {

    @IBOutlet weak var chooseLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chooseLbl.adjustsFontSizeToFitWidth = true
        chooseLbl.layer.cornerRadius = frame.size.height / 2.0
        chooseLbl.layer.masksToBounds = true
    }

}
