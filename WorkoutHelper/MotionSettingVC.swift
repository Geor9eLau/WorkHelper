//
//  MotionSettingVC.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/14.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit

class MotionSettingVC: BodyPartSettingVC {

    
    private lazy var chosenMotions: [PartMotion] = {
        switch self.type{
        case let .motion(part):
            switch part{
            case .back:
                return DataManager.userChosenBackMotions
            case .leg:
                return DataManager.userChosenLegMotions
            case .shoulder:
                return DataManager.userChosenShoulderMotions
            }
        default:
            return [PartMotion]()
        }
    }()
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenMotions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingCell
        let motion = chosenMotions[indexPath.row]
        cell.numLbl.text = "\(indexPath.row + 1)"
        cell.nameLbl.text = motion.motionName
        return cell
    }
    
    // MARK: - UITableviewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let motion = chosenMotions[indexPath.row]
        chosenMotions.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        DataManager.updateChosenMotion(chosenMotions: chosenMotions, part: motion.part)
    }
    // MARK: - CustomChooseViewDelegate
    
    override func choose(item: Any) {
        if let chosenMotion = item as? PartMotion{
            chosenMotions.append(chosenMotion)
            customTableView.reloadData()
            
            DataManager.updateChosenMotion(chosenMotions: chosenMotions, part: chosenMotion.part)
        }
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
