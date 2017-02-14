//
//  Timer.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/5.
//  Copyright © 2017年 George. All rights reserved.
//

import UIKit

protocol TimerDelegate {
    func timerDidBegan()
    func timerDidFinished(timeConsuming: String)
    func showFailureToast()
}

fileprivate let TimerBtnWidth = 165.0

class Timer: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public var delegate: TimerDelegate?
    
    private let queue: DispatchQueue = DispatchQueue.global()
    private let countDownTimer: DispatchSourceTimer = {
       let tmp = DispatchSource.makeTimerSource()
        tmp.scheduleRepeating(deadline: DispatchTime.now(), interval: .seconds(1))
        return tmp
    }()
    
    private let countTimer: DispatchSourceTimer = {
        let tmp = DispatchSource.makeTimerSource()
        tmp.scheduleRepeating(deadline: DispatchTime.now(), interval: .milliseconds(10) )
        return tmp
    }()
    
    private lazy var timerLbl: UILabel = {
       let tmp = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 40))
        tmp.textAlignment = .center
        tmp.font = UIFont.systemFont(ofSize: 28.0)
        tmp.text = "00:00:00";
        return tmp
    }()
    private lazy var timerBtn: UIButton = {
        let tmpBtn = UIButton(frame: CGRect(x: 0, y: 50, width: TimerBtnWidth, height: TimerBtnWidth))
        tmpBtn.setTitle("Start", for: .normal)
        tmpBtn.layer.cornerRadius = self.frame.size.width / 2.0
        tmpBtn.setTitleColor(UIColor.white, for: .normal)
        tmpBtn.backgroundColor = UIColor.green
        tmpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        tmpBtn.addTarget(self, action: #selector(countBtnDidClicked), for: .touchUpInside)
        return tmpBtn
    }()
    
    private var isCountingDown: Bool = true
//    private var isCountingFinished: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(timerLbl)
        addSubview(timerBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Event Handler
    func countBtnDidClicked(){
        if (delegate as? MotionViewController)?.isTimerEnabled == false {
            delegate?.showFailureToast()
            return
        }
        
        if self.isCountingDown{
            delegate?.timerDidBegan()
            self.timerBtn.setTitle("3", for: .normal)
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                var timeCount = 3
                self.countDownTimer.setEventHandler(handler: {
                    timeCount = timeCount - 1
                    if timeCount >= 0 {
                        self.timerBtn.isUserInteractionEnabled = false
                        DispatchQueue.main.async {
                            self.timerBtn.setTitle("\(timeCount)", for: .normal)
                        }
                    }else{
                        self.timerBtn.isUserInteractionEnabled = true
                        DispatchQueue.main.async {
                            self.timerBtn.setTitle("Stop", for: .normal)
                            self.timerBtn.backgroundColor = UIColor.red
                        }
                        var ms = 0
                        var s = 0
                        var m = 0
                        self.countTimer.setEventHandler {
                            ms = ms + 1
                            if ms >= 100{
                                s = s + 1
                                ms = 0
                                if s >= 60 {
                                    m = m + 1
                                    s = 0
                                }
                            }
                            DispatchQueue.main.async {
                                self.timerLbl.text = String.init(format: "%02d:%02d:%02d", arguments: [m, s, ms])
                            }
                        }
                        self.countTimer.resume()
                        self.countDownTimer.suspend()
                    }
                })
                
                self.countDownTimer.resume()
                self.isCountingDown = false
            })
        }else{
            self.countTimer.suspend()
            delegate?.timerDidFinished(timeConsuming: timerLbl.text!)
            self.timerBtn.setTitle("Start", for: .normal)
            self.timerBtn.backgroundColor = UIColor.green
            self.timerLbl.text = "00:00:00";
            self.isCountingDown = true
        }
    }
    
    
    
}
