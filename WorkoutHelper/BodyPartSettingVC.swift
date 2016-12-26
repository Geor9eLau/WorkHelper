//
//  BodyPartSettingVC.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/13.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit

class BodyPartSettingVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, CustomChooseViewDelegate {

    lazy var customTableView: UITableView = {
        let tmp = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 150))
        tmp.delegate = self
        tmp.dataSource = self
        tmp.showsVerticalScrollIndicator = false
        tmp.showsHorizontalScrollIndicator = false
        tmp.separatorStyle = .none
        tmp.backgroundColor = UIColor.white
        return tmp
    }()
    
    private lazy var doneBarBtn: UIBarButtonItem = {
        let tmpBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBtnDidClicked))
        return tmpBtn
    }()
    
    private var chosenParts: [BodyPart] = DataManager.userChosenParts
    
    var chooseView: CustomChooseView?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting Body Part"
        self.setupTableView()
        self.setupChooseView()
        navigationItem.setRightBarButton(doneBarBtn, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    func setupChooseView() {
        chooseView = CustomChooseView(CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), chooseViewType: .part, fromType: .setting)
        chooseView!.delegate = self
    }
    
    func setupTableView() {
        customTableView.register(UINib.init(nibName: "SettingCell", bundle: nil) , forCellReuseIdentifier: "settingCell")
        view.addSubview(customTableView)
    }
    
    // MARK - Event Handler
    func addBtnDidClicked() {
//        if self.chosenParts.count < ALL_BODY_PART_CHOICES.count {
        if chooseView!.hasSelectableChoice {view.addSubview(chooseView!)}
        
//        }
    }
    
    @objc func doneBtnDidClicked(){
        UIApplication.shared.keyWindow?.rootViewController = MenuViewController()
        UserDefaults.standard.set(true, forKey: "isFirstTime")
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chosenPart = self.chosenParts[indexPath.row]
        let motionVc = MotionSettingVC()
        motionVc.part = chosenPart
        navigationController?.pushViewController(motionVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        chosenParts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        DataManager.updateChosenParts(chosenParts: chosenParts)
        chooseView!.refreshView()
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenParts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingCell
        cell.numLbl.text = "\(indexPath.row + 1)"
        cell.nameLbl.text = chosenParts[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if chooseView!.hasSelectableChoice == false {return nil}
        let addView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50))
        addView.backgroundColor = UIColor.clear
        
        let addBtn = UIButton(type: .contactAdd)
        addBtn.frame = CGRect(x: 20, y: 10, width: 30, height: 30)
        addBtn.addTarget(self, action: #selector(addBtnDidClicked) , for: .touchUpInside)
        addView.addSubview(addBtn)
        
        return addView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if chooseView!.hasSelectableChoice { return 50 }
        return 0
    }

    
    // MARK: - CustomChooseViewDelegate
    func choose(item: Any) {
        
        if let chosenPart = item as? BodyPart{
            chosenParts.append(chosenPart)
            DataManager.updateChosenParts(chosenParts: chosenParts)
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
