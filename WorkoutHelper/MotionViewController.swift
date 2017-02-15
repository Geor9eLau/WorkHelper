//
//  MotionViewController.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/26.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit
import Toaster

class MotionViewController: BaseViewController, UINavigationControllerDelegate,CustomChooseViewDelegate, TimerDelegate, InfoRecordViewDelegate{
    
    public var isTimerEnabled: Bool {
        return (self.motionBtn.isSelected)
    }
    public var part: BodyPart
    private var chosenMotion: PartMotion? {
        didSet{
            if let training = DataManager.sharedInstance.getTrainingRecord(motion: chosenMotion! , trainingDate: Date()){
                self.recordTable.addRecords(motions: training.motions)
                currentGroupNo = training.numberOfGroup + 1
            }
        }
    }
    
    
    private var motionTitleLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 69, width: SCREEN_WIDTH, height: 30))
        lbl.textAlignment = .center
        lbl.text = "Motion"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 26)
        return lbl
    }()
    
    private lazy var motionBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: (SCREEN_WIDTH - 200) / 2, y: 104, width: 200, height: 40))
        
        btn.setTitle("Choose a motion", for: .normal)
        btn.setTitle("Unset", for: .selected)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.setTitleColor(UIColor.blue, for: .selected)
        btn.addTarget(self, action: #selector(motionBtnDidClicked), for: .touchUpInside)
        return btn
    }()
    
    private let recordTitleLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 160, width: SCREEN_WIDTH, height: 30))
        lbl.textAlignment = .center
        lbl.text = "Record"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 20)
        return lbl
    }()
    
    private let recordTable = RecordTable(frame: CGRect(x: 50, y: 190, width: SCREEN_WIDTH - 100, height: 220 * RatioX_47))
    private lazy var chooseView: CustomChooseView = {
        let tmp = CustomChooseView(self.view.bounds, part:self.part)
        tmp.delegate = self
        return tmp
    }()
    
    private lazy var timerScreen: Timer = {
       let tmp = Timer(frame: CGRect(x: (SCREEN_WIDTH - 165) / 2, y: SCREEN_HEIGHT - 250, width: 165, height: 210))

        tmp.delegate = self
       return tmp
    }()
    
    private lazy var infoRecordView: InfoRecordView = {
       let tmp = InfoRecordView(frame: UIScreen.main.bounds)
        tmp.delegate = self
        return tmp
    }()
    
    private var tmpTimeConsuming: UInt = 0
    private var currentGroupNo: UInt = 1
//    private var tmpMotion: Motion?
    private var training: Training?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.part.rawValue
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
        view.addSubview(motionTitleLbl)
        view.addSubview(motionBtn)
        view.addSubview(recordTitleLbl)
        view.addSubview(recordTable)
        view.addSubview(timerScreen)
        let backBtn = UIBarButtonItem.init(title: "<", style: .plain, target: self, action: #selector(backBtnDidClicked))
        backBtn.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backBtn
    }
    
    // MARK: - Event handler
    @objc func backBtnDidClicked() {
        _ = SweetAlert().showAlert("Message", subTitle: "Do you finish the training?", style: .warning, buttonTitle: "Yes", buttonColor: UIColor.green, otherButtonTitle: "No") { (isOtherBtn) in
            if isOtherBtn{
                if let training = self.training{
                    DataManager.sharedInstance.updateRecord(training: training)
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }else{
                
            }
        }
    }
    
    func motionBtnDidClicked() {
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
    }
    
    // MARK: - TimerDelegate
    func timerDidBegan() {
        self.motionBtn.isUserInteractionEnabled = false
    }

    func timerDidFinished(timeConsuming: String) {


        let timeArr = timeConsuming.components(separatedBy: ":")
        let min:UInt = UInt(timeArr.first!)!
        let sec:UInt = UInt(timeArr[1])!
        self.tmpTimeConsuming = 60 * min + sec
        
        self.infoRecordView.show()
    }
    
    func showFailureToast() {
        guard motionBtn.title(for: .selected) != "Unset" else {
            let toast = Toast(text: "Please choose a motion", delay: 0.1, duration: 0.5)
            toast.show()
            return
        }
    }
    
    // MARK: - InfoRecordViewDelegate
    func recordDidFinished(weight: Double, repeats: Int) {
        currentGroupNo = currentGroupNo + 1
        let motion = Motion.init(motionId:"\(self.chosenMotion!.motionName) \(Util.transformDateToDateStr(date: Date()))-\(currentGroupNo)", weight: weight, repeats: UInt(repeats), timeConsuming: self.tmpTimeConsuming, motionType: self.chosenMotion!)
        DataManager.sharedInstance.addMotionRecord(motion: motion)
        if self.training == nil {
            self.training = Training.init(motionType: self.chosenMotion!, trainingId: "\(self.chosenMotion!.motionName) \(Util.transformDateToDateStr(date: Date()))")
            self.training?.date = motion.date
        }
        self.training?.addMotion(motion: motion)
        self.recordTable.addRecord(motion: motion)
        self.motionBtn.isUserInteractionEnabled = true
    }
}
