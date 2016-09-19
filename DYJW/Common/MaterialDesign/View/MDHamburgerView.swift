//
//  MDHamburgerView.swift
//  DYJW
//
//  Created by FlyKite on 16/9/14.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

public enum MDHamburgerState : Int {
    case Normal
    case Back
    case PopBack
}

class MDHamburgerView: UIView {
    
    private let width : CGFloat = 56
    private let height : CGFloat = 56
    private let padding : CGFloat = 18.0
    private let lineWidth : CGFloat = 20.0
    private let lineHeight : CGFloat = 2.0
    private let interval : CGFloat = 3.0
    private let lineY : CGFloat = 28.0
    private let duration : NSTimeInterval = 0.3
    private let pi : CGFloat = CGFloat(M_PI)
    
    // Lines
    private let line1 : CAShapeLayer = CAShapeLayer.init()
    private let line2 : CAShapeLayer = CAShapeLayer.init()
    private let line3 : CAShapeLayer = CAShapeLayer.init()
    
    // HamburgerViewState
    private var _state : MDHamburgerState = MDHamburgerState.Normal
    var state : MDHamburgerState {
        get {
            return _state
        }
        set(value) {
            if value != MDHamburgerState.PopBack && _state != value {
                self.toggle()
            } else if value == MDHamburgerState.PopBack {
                self.stateValue = _state == MDHamburgerState.Normal ? 1 : 0;
                _state = MDHamburgerState.PopBack;
            }
        }
    }
    
    // The stateValue is between 0.00 and 1.00 for Hamburger rotation;
    private var _stateValue : CGFloat = 0
    var stateValue : CGFloat {
        get {
            return _stateValue
        }
        set(value) {
            let lastState = _stateValue
            _stateValue = value > 1 ? 1 : (value < 0 ? 0 : value)
            UIView.animateWithDuration(duration * 1 - Double(lastState)) {
                // 整个控件的旋转
                self.clearTransform()
                self.transform = CGAffineTransformMakeRotation(self.pi * (value + (self.state == MDHamburgerState.Normal ? 0 : 1)))
                
                // 判断是从剪头状态回到普通状态还是从普通状态转为剪头状态
                let xyValue = self.state == MDHamburgerState.Normal ? value : 1 - value
                let widthValue = self.state == MDHamburgerState.Normal ? 3 - value : 2 + value
                
                // line1的变换
                self.line1.transform = CATransform3DMakeTranslation(6 * xyValue, 1 * xyValue, 0)
                self.line1.transform = CATransform3DRotate(self.line1.transform, self.pi / 4 * xyValue, 0, 0, 1)
                self.line1.transform = CATransform3DScale(self.line1.transform, widthValue / 3, 1, 1)
                
                // line3的变换
                self.line3.transform = CATransform3DMakeTranslation(6 * xyValue, -1 * xyValue, 0)
                self.line3.transform = CATransform3DRotate(self.line3.transform, -self.pi / 4 * xyValue, 0, 0, 1)
                self.line3.transform = CATransform3DScale(self.line3.transform, widthValue / 3, 1, 1)
            }
            _state = value == 1 ? (_state == MDHamburgerState.Normal ? MDHamburgerState.Back : MDHamburgerState.Normal) : _state;
            _stateValue = value == 1 ? 0 : value;
        }
    }
    
    func toggle() {
        UIView.animateWithDuration(duration * (1 - Double(_stateValue)), animations: {
            self.stateValue = 1
        }) { (finished : Bool) in
            if self.state == MDHamburgerState.Normal {
                self.transform = CGAffineTransformMakeRotation(0);
            }
        }
    }
    
    private func clearTransform() {
        self.transform = CGAffineTransformMakeRotation(0);
        self.line1.transform = CATransform3DMakeRotation(0, 0, 0, 0)
        self.line1.transform = CATransform3DScale(self.line1.transform, 1, 1, 1)
        self.line3.transform = CATransform3DMakeRotation(0, 0, 0, 0)
        self.line3.transform = CATransform3DScale(self.line3.transform, 1, 1, 1)
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 56.0, height: 56.0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: height))
        for index in 0...2 {
            let path = UIBezierPath.init()
            path.moveToPoint(CGPoint(x: padding, y: lineY))
            path.addLineToPoint(CGPoint(x: padding + lineWidth, y: lineY))
            var line : CAShapeLayer
            switch index {
            case 0: line = line1
            case 1: line = line2
            case 2: line = line3
            default: line = line1
            }
            line.frame = CGRect(x: 0, y: (lineHeight + interval) * CGFloat(index - 1), width: width, height: height)
            line.path = path.CGPath
            line.lineWidth = lineHeight
            line.strokeColor = UIColor.whiteColor().CGColor
            line.fillColor = UIColor.clearColor().CGColor
            self.layer.addSublayer(line)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
