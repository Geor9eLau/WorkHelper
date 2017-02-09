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
    private lazy var timerScreen: UIButton = {
        let tmpBtn = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        tmpBtn.setTitle("3", for: .normal)
        tmpBtn.setTitleColor(UIColor.black, for: .normal)
        tmpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
//        tmpBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        tmpBtn.addTarget(self, action: #selector(countBtnDidClicked), for: .touchUpInside)
        return tmpBtn
    }()
    
    private var isCountingDown: Bool = true
    private var isCountingFinished: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        addSubview(timerScreen)
        
        
        self.resetCountTimer()
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
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                var timeCount = 3
                self.countDownTimer.setEventHandler(handler: {
                    timeCount = timeCount - 1
                    if timeCount >= 0 {
                        DispatchQueue.main.async {
                            self.timerScreen.setTitle("\(timeCount)", for: .normal)
                        }
                    }else{
//                        self.resetCountTimer()
                        var ms = 0
                        var s = 0
                        var m = 0
                        self.countTimer.setEventHandler {
                            self.timerScreen.isUserInteractionEnabled = true
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
                                self.timerScreen.setTitle(String.init(format: "%02d:%02d:%02d", arguments: [m, s, ms]), for: .normal)
                            }
                        }
                        self.countTimer.resume()
                        self.countDownTimer.suspend()
                        timeCount = 3
                    }
                })
                
                self.countDownTimer.resume()
                self.isCountingDown = false
            })
//            self.timerScreen.isEnabled = false
        }else{
            if self.isCountingFinished {
//                self.countTimer.suspend()
                self.timerScreen.setTitle("3", for: .normal)
                self.isCountingDown = true
                self.isCountingFinished = false
            }else{
                self.countTimer.suspend()
                self.isCountingFinished = true
                delegate?.timerDidFinished(timeConsuming: timerScreen.title(for: .normal)!)
            }
            
//            self.timerScreen.isEnabled = true
        }
    }
    
    
    func resetCountTimer() {
        var ms = 0
        var s = 0
        var m = 0
        self.countTimer.setEventHandler {
            self.timerScreen.isUserInteractionEnabled = true
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
                self.timerScreen.setTitle(String.init(format: "%02d:%02d:%02d", arguments: [m, s, ms]), for: .normal)
            }
        }
    }
    
}
