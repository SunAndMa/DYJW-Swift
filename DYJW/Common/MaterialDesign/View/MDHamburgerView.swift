//
//  MDHamburgerView.swift
//  DYJW
//
//  Created by FlyKite on 16/9/14.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

public enum MDHamburgerState: Int {
    case Normal
    case Back
    case PopBack
}

class MDHamburgerView: UIView {
    
    private let width: CGFloat = 56
    private let height: CGFloat = 56
    private let padding: CGFloat = 18.0
    private let lineWidth: CGFloat = 20.0
    private let lineHeight: CGFloat = 2.0
    private let interval: CGFloat = 3.0
    private let lineY: CGFloat = 28.0
    private let duration: NSTimeInterval = 0.3
    private let pi: CGFloat = CGFloat(M_PI)
    
    // Lines
    private let line1: CAShapeLayer = CAShapeLayer.init()
    private let line2: CAShapeLayer = CAShapeLayer.init()
    private let line3: CAShapeLayer = CAShapeLayer.init()
    
    // HamburgerViewState
    private var _state: MDHamburgerState = MDHamburgerState.Normal
    var state: MDHamburgerState {
        get {
            return _state
        }
        set(value) {
            if value != MDHamburgerState.PopBack {
                if _state != value {
                    stateValue = value == MDHamburgerState.Normal ? 0 : 1
                    _state = value
                } else {
                    stateValue = value == MDHamburgerState.Normal ? 0 : 1
                }
            } else {
                stateValue = _state == MDHamburgerState.Normal ? 1 : 0
                _state = MDHamburgerState.PopBack
            }
        }
    }
    
    // The stateValue is between 0.00 and 1.00 for Hamburger rotation
    private var _stateValue: CGFloat = 0
    var stateValue: CGFloat {
        get {
            return _stateValue
        }
        set(value) {
            let lastState = _stateValue
            _stateValue = value > 1 ? 1: (value < 0 ? 0: value)
            
            // 整个控件的旋转
            let rotate = CABasicAnimation.init(keyPath: "transform.rotation.z")
            rotate.fromValue = NSNumber.init(float: Float(self.pi * (self.state == MDHamburgerState.Normal ? lastState : 2 - lastState)))
            rotate.toValue = NSNumber.init(float: Float(self.pi * (self.state == MDHamburgerState.Normal ? value : 2 - value)))
            rotate.fillMode = kCAFillModeBoth
            rotate.removedOnCompletion = false
            rotate.duration = duration * 1 - Double(lastState)
            self.layer.addAnimation(rotate, forKey: nil)
            
            // 两条横线长度变化的值
            let widthValue = 3 - value
            
            // Line1的变换
            let line1Move = CABasicAnimation.init(keyPath: "position")
            line1Move.toValue = NSValue.init(CGPoint: CGPoint(x: 6 * value + width / 2, y: 1 * value + lineY - lineHeight - interval))
            let line1Rotate = CABasicAnimation.init(keyPath: "transform.rotation.z")
            line1Rotate.toValue = NSNumber.init(float: Float(pi) / 4 * Float(value))
            let line1Scale = CABasicAnimation.init(keyPath: "transform.scale.x")
            line1Scale.toValue = NSNumber.init(float: Float(widthValue) / 3)
            let line1Group = CAAnimationGroup.init()
            line1Group.animations = [line1Move, line1Rotate, line1Scale]
            line1Group.fillMode = kCAFillModeBoth
            line1Group.removedOnCompletion = false
            line1Group.duration = duration * 1 - Double(lastState)
            self.line1.addAnimation(line1Group, forKey: nil)
            
            // Line3的变换
            let line3Move = CABasicAnimation.init(keyPath: "position")
            line3Move.toValue = NSValue.init(CGPoint: CGPoint(x: 6 * value + width / 2, y: -1 * value + lineY + lineHeight + interval))
            let line3Rotate = CABasicAnimation.init(keyPath: "transform.rotation.z")
            line3Rotate.toValue = NSNumber.init(float: Float(-pi) / 4 * Float(value))
            let line3Scale = CABasicAnimation.init(keyPath: "transform.scale.x")
            line3Scale.toValue = NSNumber.init(float: Float(widthValue) / 3)
            let line3Group = CAAnimationGroup.init()
            line3Group.animations = [line3Move, line3Rotate, line3Scale]
            line3Group.fillMode = kCAFillModeBoth
            line3Group.removedOnCompletion = false
            line3Group.duration = duration * 1 - Double(lastState)
            self.line3.addAnimation(line3Group, forKey: nil)
            
            _stateValue = value;
        }
    }
    
    // MARK:- initialize
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 56.0, height: 56.0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: height))
        for index in 0...2 {
            let path = UIBezierPath.init()
            path.moveToPoint(CGPoint(x: padding, y: lineY))
            path.addLineToPoint(CGPoint(x: padding + lineWidth, y: lineY))
            var line: CAShapeLayer
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
