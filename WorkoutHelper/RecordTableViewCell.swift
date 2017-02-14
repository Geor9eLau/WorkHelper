//
//  RecordTableViewCell.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/13.
//  Copyright © 2017年 George. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    
    @IBOutlet weak var repeatsLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        numberLbl.layer.borderWidth = 1.0
        numberLbl.layer.borderColor = UIColor.black.cgColor
        weightLbl.layer.borderWidth = 1.0
        weightLbl.layer.borderColor = UIColor.black.cgColor
        repeatsLbl.layer.borderWidth = 1.0
        repeatsLbl.layer.borderColor = UIColor.black.cgColor
        timeLbl.layer.borderWidth = 1.0
        timeLbl.layer.borderColor = UIColor.black.cgColor
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
