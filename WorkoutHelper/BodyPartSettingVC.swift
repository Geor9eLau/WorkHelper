//
//  BodyPartSettingVC.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/13.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit

class BodyPartSettingVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, CustomChooseViewDelegate {

    @IBOutlet weak var customTableView: UITableView!
    
    var type: ChooseViewType = .part
    var chosenParts: [BodyPart] = {
        return USER_CHOSEN_PARTS
    }()
    
    lazy var chooseView: CustomChooseView = {
        let tmp = CustomChooseView(CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), type: self.type)
        tmp.delegate = self
        return tmp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting Body Part"
        self.setupTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    func setupTableView() {
        customTableView.register(UINib.init(nibName: "SettingCell", bundle: nil) , forCellReuseIdentifier: "settingCell")
    }
    
    // MARK - Event Handler
    func addBtnDidClicked() {
        if self.chosenParts.count < ALL_BODY_PART_CHOICES.count {
            view.addSubview(self.chooseView)
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenParts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingCell
        cell.numLbl.text = "\(indexPath.row + 1)"
        cell.partLbl.text = chosenParts[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let addView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
        addView.backgroundColor = UIColor.clear
        
        
        let addBtn = UIButton(type: .contactAdd)
        addBtn.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        addBtn.addTarget(self, action: #selector(addBtnDidClicked) , for: .touchUpInside)
        addView.addSubview(addBtn)
        
        return addView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

    
    // MARK - CustomChooseViewDelegate
    func choose(item: String) {
        chosenParts.append(BodyPart(rawValue: item)!)
        customTableView.reloadData()
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
