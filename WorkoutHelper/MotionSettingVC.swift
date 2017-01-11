//
//  MotionSettingVC.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/14.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit

class MotionSettingVC: BodyPartSettingVC {

    var part: BodyPart?
    
    private lazy var chosenMotions: [PartMotion] = {
        switch self.part!{
        case .back:
            return DataManager.sharedInstance.userChosenBackMotions
        case .leg:
            return DataManager.sharedInstance.userChosenLegMotions
        case .shoulder:
            return DataManager.sharedInstance.userChosenShoulderMotions
        }
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = part?.rawValue
        navigationItem.rightBarButtonItem = nil
    }

    
    // MARK: - Private
    
    override func setupChooseView() {
        chooseView = CustomChooseView(CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), chooseViewType: .motion(partType: self.part!), fromType: .setting)
        chooseView?.delegate = self
    }
    // MARK: - Event Handler
    override func addBtnDidClicked() {
        if chooseView!.hasSelectableChoice {view.addSubview(chooseView!)}
    }
    
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
        DataManager.sharedInstance.updateChosenMotion(chosenMotions: chosenMotions, part: motion.part)
        chooseView!.refreshView()
        
        tableView.reloadData()
    }
    
    
    // MARK: - CustomChooseViewDelegate
    
    override func choose(item: Any) {
        if let chosenMotion = item as? PartMotion{
            chosenMotions.append(chosenMotion)
            DataManager.sharedInstance.updateChosenMotion(chosenMotions: chosenMotions, part: chosenMotion.part)
            chooseView!.refreshView()
            
            customTableView.reloadData()
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
