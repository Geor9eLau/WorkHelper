//
//  GraphicDataHomePageTableViewCell.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/15.
//  Copyright © 2017年 George. All rights reserved.
//

import UIKit

class GraphicDataHomePageTableViewCell: UITableViewCell {

    @IBOutlet weak var partNameLbl: UILabel!
   
    @IBOutlet weak var recordMsgLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
