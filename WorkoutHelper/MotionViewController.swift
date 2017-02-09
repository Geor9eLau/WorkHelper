//
//  MotionViewController.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/26.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit
import Toaster

class MotionViewController: BaseViewController, UINavigationControllerDelegate,CustomChooseViewDelegate, TimerDelegate{
    
    public var isTimerEnabled: Bool {
        return (self.motionBtn.isSelected)
            && (self.repeatsBtn.isSelected)
            && (self.weightBtn.isSelected)
    }
    public var part: BodyPart
    private var chosenMotion: PartMotion?
    
    private var motionNameLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 30, y: 80, width: 80, height: 30))
        lbl.text = "动作"
        lbl.textColor = UIColor.blue
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private lazy var motionBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 180, y: 80, width: 140, height: 30))
        btn.setTitle("选择一个动作", for: .normal)
        btn.setTitle("Unset", for: .selected)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.setTitleColor(UIColor.red, for: .selected)
        btn.addTarget(self, action: #selector(motionBtnDidClicked), for: .touchUpInside)
        return btn
    }()
    
    private var weightLbl: UILabel = {
        let lbl =  UILabel(frame: CGRect(x: 30, y: 130, width: 80, height: 30))
        lbl.text = "当前组重量"
        lbl.textColor = UIColor.blue
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private lazy var weightBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 180, y: 130, width: 140, height: 30))
        btn.setTitle("设置重量", for: .normal)
        btn.setTitle("Unset", for: .selected)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.setTitleColor(UIColor.red, for: .selected)
        btn.addTarget(self, action: #selector(weightBtnDidClicked), for: .touchUpInside)
        return btn
    }()
    
    private var repeatsLbl: UILabel = {
        let lbl =  UILabel(frame: CGRect(x: 30, y: 180, width: 80, height: 30))
        lbl.text = "当前组数量"
        lbl.textColor = UIColor.blue
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private lazy var repeatsBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 180, y: 180, width: 140, height: 30))
        btn.setTitle("设置数量", for: .normal)
        btn.setTitle("Unset", for: .selected)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.setTitleColor(UIColor.red, for: .selected)
        btn.addTarget(self, action: #selector(repeatsBtnDidClicked), for: .touchUpInside)
        return btn
    }()
    
    private var totalGroupLbl: UILabel = {
        let lbl =  UILabel(frame: CGRect(x: 30, y: 230, width: 80, height: 30))
        lbl.text = "总组数"
        lbl.textColor = UIColor.blue
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private var totalGroupCountLbl: UILabel = {
        let lbl =  UILabel(frame: CGRect(x: 180, y: 230, width: 80, height: 30))
        lbl.text = "0"
        lbl.textColor = UIColor.gray
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private lazy var chooseView: CustomChooseView = {
       let tmp = CustomChooseView(self.view.bounds, chooseViewType: .none, fromType: .training)
        tmp.delegate = self
        return tmp
    }()
    
    private lazy var timerScreen: Timer = {
       let tmp = Timer(frame: CGRect(x: 100, y: 280, width: SCREEN_WIDTH - 200, height: SCREEN_WIDTH - 200))
        tmp.delegate = self
       return tmp
    }()
    
    private var totalGroup: Int = 0
    
    private var training: Training?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
    }
    // MARK: - Initialize

    init(part: BodyPart) {
        self.part = part
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Override
    
    
   // MARK: - Private
    func setupUI() {
        view.addSubview(motionNameLbl)
        view.addSubview(repeatsLbl)
        view.addSubview(weightLbl)
        view.addSubview(totalGroupLbl)
        view.addSubview(motionBtn)
        view.addSubview(weightBtn)
        view.addSubview(repeatsBtn)
        view.addSubview(totalGroupCountLbl)
        view.addSubview(timerScreen)
        let backBtn = UIBarButtonItem.init(title: "Back", style: .plain, target: self, action: #selector(backBtnDidClicked))
        navigationItem.leftBarButtonItem = backBtn
    }
    
    // MARK: - Event handler
    @objc func backBtnDidClicked() {
        _ = SweetAlert().showAlert("提示", subTitle: "是否结束本次训练", style: .warning, buttonTitle: "确定", buttonColor: UIColor.green, otherButtonTitle: "取消") { (isOtherBtn) in
            if isOtherBtn{
                _ = self.navigationController?.popViewController(animated: true)
            }else{
                
            }
        }
    }
    
    func motionBtnDidClicked() {
        self.chooseView.chooseViewType = .motion(partType: self.part)
        self.chooseView.refreshView()
        UIApplication.shared.keyWindow?.addSubview(self.chooseView)
    }
    
    func weightBtnDidClicked() {
        guard (self.chosenMotion != nil) else {
            let toast = Toast(text: "Please choose a motion", delay: 0.1, duration: 0.5)
            toast.show()
            return
        }
        var partMotion: PartMotion
        switch self.part {
        case .back:
            partMotion = BackMotion(rawValue: (self.chosenMotion?.motionName)!)!
        case .leg:
            partMotion = LegMotion(rawValue: (self.chosenMotion?.motionName)!)!
        case .shoulder:
            partMotion = ShoulderMotion(rawValue: (self.chosenMotion?.motionName)!)!
        }
        self.chooseView.chooseViewType = .weight(motionType: partMotion)
        self.chooseView.refreshView()
        UIApplication.shared.keyWindow?.addSubview(self.chooseView)
    }
    
    func repeatsBtnDidClicked() {
        guard (self.chosenMotion != nil) else {
            let toast = Toast(text: "Please choose a motion", delay: 0.1, duration: 0.5)
            toast.show()
            return
        }
        var partMotion: PartMotion
        switch self.part {
        case .back:
            partMotion = BackMotion(rawValue: (self.chosenMotion?.motionName)!)!
        case .leg:
            partMotion = LegMotion(rawValue: (self.chosenMotion?.motionName)!)!
        case .shoulder:
            partMotion = ShoulderMotion(rawValue: (self.chosenMotion?.motionName)!)!
        }
        self.chooseView.chooseViewType = .repeats(motionType: partMotion)
        self.chooseView.refreshView()
        UIApplication.shared.keyWindow?.addSubview(self.chooseView)
    }
    
    
    // MARK: - ChooseViewDelegate
    func choose(item: Any) {
        if let motion = item as? PartMotion{
            self.chosenMotion = motion
            motionBtn.isSelected = true
            motionBtn.setTitleColor(UIColor.red, for: .selected)
            motionBtn.setTitle(motion.motionName, for: .selected)
        }
        else if item is Double{
            self.weightBtn.isSelected = true
            self.weightBtn.setTitle("\(item)", for: .selected)
        }
        else if item is Int{
            self.repeatsBtn.isSelected = true
            self.repeatsBtn.setTitle("\(item)", for: .selected)
        }
    }
    
    // MARK: - TimerDelegate
    func timerDidBegan() {
        self.motionBtn.isUserInteractionEnabled = false
        self.weightBtn.isUserInteractionEnabled = false
        self.repeatsBtn.isUserInteractionEnabled = false
    }

    func timerDidFinished(timeConsuming: String) {
        self.totalGroup = self.totalGroup + 1
        self.totalGroupCountLbl.text = "\(self.totalGroup)"

        let timeArr = timeConsuming.components(separatedBy: ":")
        let min:UInt = UInt(timeArr.first!)!
        let sec:UInt = UInt(timeArr[1])!
        let tmpTimeConsuming = 60 * min + sec
        
        let motion = Motion.init(weight: Float(self.weightBtn.title(for: .selected)!)!, repeats: UInt(self.repeatsBtn.title(for: .selected)!)!, timeConsuming: tmpTimeConsuming, motionType: self.chosenMotion!)
        
        DataManager.sharedInstance.addMotionRecord(motion: motion)
        if self.training == nil {
            self.training = Training.init(motionType: self.chosenMotion!)
            self.training?.date = motion.date
        }
        self.training?.addMotion(motion: motion)
        
        self.motionBtn.isUserInteractionEnabled = true
        self.weightBtn.isUserInteractionEnabled = true
        self.repeatsBtn.isUserInteractionEnabled = true
    }
    
    func showFailureToast() {
        guard motionBtn.title(for: .selected) != "Unset" else {
            let toast = Toast(text: "Please choose a motion", delay: 0.1, duration: 0.5)
            toast.show()
            return
        }
        
        guard repeatsBtn.title(for: .selected) != "Unset" else {
            let toast = Toast(text: "Please choose repeats", delay: 0.1, duration: 0.5)
            toast.show()
            return
        }
        
        guard motionBtn.title(for: .selected) != "Unset" else {
            let toast = Toast(text: "Please choose weight", delay: 0.1, duration: 0.5)
            toast.show()
            return
        }
    }
    
    
}
