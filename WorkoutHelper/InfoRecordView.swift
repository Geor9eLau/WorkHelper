//
//  InfoRecordView.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/13.
//  Copyright © 2017年 George. All rights reserved.
//

import UIKit
import Toaster

protocol InfoRecordViewDelegate {
    func recordDidFinished(weight: Double, repeats: Int)
}

class InfoRecordView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    public var delegate: InfoRecordViewDelegate?
    
    private var weight: Double = 0
    private var repeats: Int = 0

    private let backView: UIView = {
        let tmp = UIView(frame: UIScreen.main.bounds)
        tmp.backgroundColor = UIColor.black
        tmp.alpha = 0.6
        return tmp
    }()
    
    private let weightRecordBackView: UIView = {
       let tmp = UIView(frame: CGRect(x: 50, y: 160, width: SCREEN_WIDTH - 100, height: 180))
        tmp.backgroundColor = UIColor.white
        tmp.layer.cornerRadius = 10.0
        return tmp
    }()
    
    private let repeatsRecordBackView: UIView = {
        let tmp = UIView(frame: CGRect(x: 50 + SCREEN_WIDTH, y: 160, width: SCREEN_WIDTH - 100, height: 160))
        tmp.backgroundColor = UIColor.white
        tmp.layer.cornerRadius = 10.0
        return tmp
    }()
    
    private let weightTitleLbl: UILabel = {
        let tmp = UILabel(frame: CGRect(x: 0, y: 20, width: SCREEN_WIDTH - 100, height: 30))
        tmp.text = "How much weight"
        tmp.textAlignment = .center
        tmp.font = UIFont.systemFont(ofSize: 24)
        tmp.textColor = UIColor.black
        return tmp
    }()

    
    private let weightTf: UITextField = {
       let tmp = UITextField(frame: CGRect(x: (SCREEN_WIDTH - 100 - 50) / 2, y: 80, width: 50, height: 30))
        tmp.borderStyle = .none
        tmp.keyboardType = .decimalPad
        tmp.textColor = UIColor.green
        tmp.font = UIFont.systemFont(ofSize: 20)
        return tmp
    }()
    
    private let weightUnitLbl: UILabel = {
        let tmp = UILabel(frame: CGRect(x: (SCREEN_WIDTH - 100 - 50) / 2 + 50, y: 80, width: 40, height: 30))
        tmp.text = "kg"
        tmp.font = UIFont.systemFont(ofSize: 20)
        tmp.textColor = UIColor.black
        return tmp
    }()
    
    private let repeatsTitleLbl: UILabel = {
        let tmp = UILabel(frame: CGRect(x: 0, y: 20, width: SCREEN_WIDTH - 100, height: 30))
        tmp.text = "How many repeats"
        tmp.textAlignment = .center
        tmp.font = UIFont.systemFont(ofSize: 24)
        tmp.textColor = UIColor.black
        return tmp
    }()
    
    private let repeatsTf: UITextField = {
        let tmp = UITextField(frame: CGRect(x: (SCREEN_WIDTH - 100 - 50) / 2, y: 80, width: 50, height: 30))
        tmp.borderStyle = .none
        tmp.keyboardType = .numberPad
        tmp.textColor = UIColor.green
        tmp.font = UIFont.systemFont(ofSize: 20)
        return tmp
    }()
    
    private let repeatUnitLbl: UILabel = {
        let tmp = UILabel(frame: CGRect(x: (SCREEN_WIDTH - 100 - 50) / 2 + 50, y: 80, width: 90, height: 30))
        tmp.text = "repeats"
        tmp.font = UIFont.systemFont(ofSize: 20)
        tmp.textColor = UIColor.black
        return tmp
    }()
    
    private lazy var nextBtn: UIButton = {
        let tmp = UIButton(frame: CGRect(x: SCREEN_WIDTH - 120, y: SCREEN_HEIGHT - 270, width: 100, height: 40))
        tmp.setTitle("Next >>", for: .normal)
        tmp.layer.cornerRadius = 5.0
        tmp.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tmp.backgroundColor = UIColor.blue
        tmp.addTarget(self, action: #selector(nextBtnDidClicked), for: .touchUpInside)
        return tmp
    }()
    
    private lazy var doneBtn: UIButton = {
        let tmp = UIButton(frame: CGRect(x: SCREEN_WIDTH - 120, y: SCREEN_HEIGHT - 270, width: 100, height: 40))
        tmp.setTitle("Done !!", for: .normal)
        tmp.layer.cornerRadius = 5.0
        tmp.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tmp.backgroundColor = UIColor.blue
        tmp.addTarget(self, action: #selector(doneBtnDidClicked), for: .touchUpInside)
        tmp.isHidden = true
        return tmp
    }()
    
    // MARK: - Public
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        self.weightTf.becomeFirstResponder()
    }
    
    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        addSubview(weightRecordBackView)
        weightRecordBackView.addSubview(weightTitleLbl)
        weightRecordBackView.addSubview(weightTf)
        weightRecordBackView.addSubview(weightUnitLbl)
        addSubview(repeatsRecordBackView)
        repeatsRecordBackView.addSubview(repeatsTitleLbl)
        repeatsRecordBackView.addSubview(repeatsTf)
        repeatsRecordBackView.addSubview(repeatUnitLbl)
        
        addSubview(nextBtn)
        addSubview(doneBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Event Handlers
    @objc private func nextBtnDidClicked() {
        guard self.weightTf.text?.characters.count != 0 else {
            let toast = Toast(text: "Please enter the weight", delay: 0.1, duration: 0.5)
            toast.show()
            return
        }
        self.weight = Double(self.weightTf.text!)!
        
        
        UIView.animate(withDuration: 1, animations: {[weak self] in
            let originalFrame = self?.weightRecordBackView.frame
            self?.weightRecordBackView.frame = CGRect(x: CGFloat(Double((originalFrame?.origin.x)!) - SCREEN_WIDTH), y: CGFloat(Double((originalFrame?.origin.y)!)), width: (originalFrame?.size.width)!, height: (originalFrame?.size.height)!)
            self?.repeatsRecordBackView.frame = originalFrame!
        })
        self.nextBtn.isHidden = true
        self.doneBtn.isHidden = false
        self.repeatsTf.becomeFirstResponder()
    }
    
    @objc private func doneBtnDidClicked() {
        guard self.repeatsTf.text?.characters.count != 0 else {
            let toast = Toast(text: "Please enter the repeats", delay: 0.1, duration: 0.5)
            toast.show()
            return
        }
        self.repeats = Int(self.repeatsTf.text!)!
        self.delegate?.recordDidFinished(weight: self.weight, repeats: self.repeats)
        
        self.removeFromSuperview()
        self.weightRecordBackView.frame = CGRect(x: 50, y: 160, width: SCREEN_WIDTH - 100, height: 160)
        self.repeatsRecordBackView.frame = CGRect(x: 50 + SCREEN_WIDTH, y: 160, width: SCREEN_WIDTH - 100, height: 160)
        self.nextBtn.isHidden = false
        self.doneBtn.isHidden = true
        self.repeatsTf.resignFirstResponder()
    }
}
