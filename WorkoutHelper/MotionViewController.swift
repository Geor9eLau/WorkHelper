//
//  MotionViewController.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/26.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit

class MotionViewController: BaseViewController, CustomChooseViewDelegate {
    
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
    
    private var repeatsLbl: UILabel = {
        let lbl =  UILabel(frame: CGRect(x: 30, y: 180, width: 80, height: 30))
        lbl.text = "当前组数量"
        lbl.textColor = UIColor.blue
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private var totalGroupLbl: UILabel = {
        let lbl =  UILabel(frame: CGRect(x: 30, y: 230, width: 80, height: 30))
        lbl.text = "总组数"
        lbl.textColor = UIColor.blue
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private lazy var motionChooseView: CustomChooseView = {
       let tmp = CustomChooseView(self.view.bounds, chooseViewType: .motion(partType: self.part), fromType: .training)
        tmp.delegate = self
        return tmp
    }()
    
    private lazy var weightChooseView: CustomChooseView = {
        let tmp = CustomChooseView(self.view.bounds, chooseViewType: .weight(motionType: self.chosenMotion!), fromType: .training)
        tmp.delegate = self
        return tmp
    }()
    
    private lazy var repeatsChooseView: CustomChooseView = {
        let tmp = CustomChooseView(self.view.bounds, chooseViewType: .repeats(motionType: self.chosenMotion!), fromType: .training)
        tmp.delegate = self
        return tmp
    }()
    
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
    
    
   // MARK: - Private
    func setupUI() {
        view.addSubview(motionNameLbl)
        view.addSubview(repeatsLbl)
        view.addSubview(weightLbl)
        view.addSubview(totalGroupLbl)
        view.addSubview(motionBtn)
    }
    
    // MARK: - Event handler
    func motionBtnDidClicked() {
        UIApplication.shared.keyWindow?.addSubview(self.motionChooseView)
    }

    // MARK: - ChooseViewDelegate
    func choose(item: Any) {
        if let motion = item as? PartMotion{
            self.chosenMotion = motion
            motionBtn.isSelected = true
            motionBtn.setTitleColor(UIColor.red, for: .selected)
            motionBtn.setTitle(motion.motionName, for: .selected)
        }
    }
}
