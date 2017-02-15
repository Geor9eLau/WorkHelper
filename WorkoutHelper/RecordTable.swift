//
//  RecordTable.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/13.
//  Copyright © 2017年 George. All rights reserved.
//

import UIKit

class RecordTable: UIView, UITableViewDataSource, UITableViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private lazy var tableView: UITableView = {
        let tmp = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), style: .plain)
        tmp.delegate = self
        tmp.dataSource = self
        tmp.backgroundColor = UIColor.clear
        tmp.allowsSelection = false
        tmp.separatorStyle = .none
        return tmp
    }()
    
    private var rows: Int = 6
    private var dataSource: [Motion] = []
    
    // MARK: -Public
    public func addRecord(motion: Motion) {
        dataSource.append(motion)
        if dataSource.count > rows {
            rows = rows + 1
        }
        tableView.reloadData()
    }
    
    public func addRecords(motions: [Motion]){
        for motion in motions{
            dataSource.append(motion)
        }
        if dataSource.count > rows {
            rows = rows + 1
        }
        tableView.reloadData()
    }
    
    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.register(UINib.init(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "recordCell")
        tableView.reloadData()
        addSubview(tableView)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordTableViewCell
//        if indexPath.row == 0 {
//            cell.numberLbl.text = "No"
//            
//            cell.weightLbl.textColor = UIColor.black
//            cell.repeatsLbl.textColor = UIColor.black
//            cell.timeLbl.textColor = UIColor.black
//            
//            cell.weightLbl.text = "Weight/kg"
//            cell.repeatsLbl.text = "Repeats"
//            cell.timeLbl.text = "Time/s"
//        }else{
        
            cell.numberLbl.text = "\(indexPath.row + 1)"
            cell.weightLbl.textColor = UIColor.blue
            cell.repeatsLbl.textColor = UIColor.blue
            cell.timeLbl.textColor = UIColor.blue
            
            if dataSource.count > 0
                && dataSource.count > indexPath.row{
                let motion = dataSource[indexPath.row]
                cell.weightLbl.text = "\(motion.weight)"
                cell.repeatsLbl.text = "\(motion.repeats)"
                cell.timeLbl.text = "\(motion.timeConsuming)"
            }else{
                cell.weightLbl.text = ""
                cell.repeatsLbl.text = ""
                cell.timeLbl.text = ""
            }
//        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = RecordTableSectionHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
}
