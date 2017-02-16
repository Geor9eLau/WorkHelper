//
//  GraphicDataViewController.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/15.
//  Copyright © 2017年 George. All rights reserved.
//

import UIKit

class GraphicDataViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Data"
        tableView.register(UINib.init(nibName: "GraphicDataHomePageTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let part = ALL_BODY_PART_CHOICES[indexPath.row]
        let detailVc = DataDetailViewController(nibName: "DataDetailViewController", bundle: nil)
        detailVc.part = part
        detailVc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVc, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ALL_BODY_PART_CHOICES.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GraphicDataHomePageTableViewCell
        let part = ALL_BODY_PART_CHOICES[indexPath.row]
        cell.partNameLbl.text = part.rawValue
        cell.recordMsgLbl.text = DataManager.sharedInstance.getRecordDescription(part: part)
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
