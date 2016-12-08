//
//  MDHamburgerView.swift
//  DYJW
//
//  Created by FlyKite on 16/9/14.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

public enum MDHamburgerState: Int {
    case normal
    case back
    case popBack
}

class MDHamburgerView: UIView {
    
    fileprivate let width: CGFloat = 56
    fileprivate let height: CGFloat = 56
    fileprivate let padding: CGFloat = 18.0
    fileprivate let lineWidth: CGFloat = 20.0
    fileprivate let lineHeight: CGFloat = 2.0
    fileprivate let interval: CGFloat = 3.0
    fileprivate let lineY: CGFloat = 28.0
    fileprivate let duration: TimeInterval = 0.3
    fileprivate let pi: CGFloat = CGFloat(M_PI)
    
    // Lines
    fileprivate let line1: CAShapeLayer = CAShapeLayer.init()
    fileprivate let line2: CAShapeLayer = CAShapeLayer.init()
    fileprivate let line3: CAShapeLayer = CAShapeLayer.init()
    
    // HamburgerViewState
    fileprivate var _state: MDHamburgerState = MDHamburgerState.normal
    var state: MDHamburgerState {
        get {
            return _state
        }
        set(value) {
            if value != MDHamburgerState.popBack {
                if _state != value {
                    stateValue = value == MDHamburgerState.normal ? 0 : 1
                    _state = value
                } else {
                    stateValue = value == MDHamburgerState.normal ? 0 : 1
                }
            } else {
                stateValue = _state == MDHamburgerState.normal ? 1 : 0
                _state = MDHamburgerState.popBack
            }
        }
    }
    
    // The stateValue is between 0.00 and 1.00 for Hamburger rotation
    fileprivate var _stateValue: CGFloat = 0
    var stateValue: CGFloat {
        get {
            return _stateValue
        }
        set(value) {
            let lastState = _stateValue
            _stateValue = value > 1 ? 1: (value < 0 ? 0: value)
            
            // 整个控件的旋转
            let rotate = CABasicAnimation.init(keyPath: "transform.rotation.z")
            rotate.fromValue = NSNumber.init(value: Float(self.pi * (self.state == MDHamburgerState.normal ? lastState : 2 - lastState)) as Float)
            rotate.toValue = NSNumber.init(value: Float(self.pi * (self.state == MDHamburgerState.normal ? value : 2 - value)) as Float)
            rotate.fillMode = kCAFillModeBoth
            rotate.isRemovedOnCompletion = false
            rotate.duration = duration * 1 - Double(lastState)
            self.layer.add(rotate, forKey: nil)
            
            // 两条横线长度变化的值
            let widthValue = 3 - value
            
            // Line1的变换
            let line1Move = CABasicAnimation.init(keyPath: "position")
            line1Move.toValue = NSValue.init(cgPoint: CGPoint(x: 6 * value + width / 2, y: 1 * value + lineY - lineHeight - interval))
            let line1Rotate = CABasicAnimation.init(keyPath: "transform.rotation.z")
            line1Rotate.toValue = NSNumber.init(value: Float(pi) / 4 * Float(value) as Float)
            let line1Scale = CABasicAnimation.init(keyPath: "transform.scale.x")
            line1Scale.toValue = NSNumber.init(value: Float(widthValue) / 3 as Float)
            let line1Group = CAAnimationGroup.init()
            line1Group.animations = [line1Move, line1Rotate, line1Scale]
            line1Group.fillMode = kCAFillModeBoth
            line1Group.isRemovedOnCompletion = false
            line1Group.duration = duration * 1 - Double(lastState)
            self.line1.add(line1Group, forKey: nil)
            
            // Line3的变换
            let line3Move = CABasicAnimation.init(keyPath: "position")
            line3Move.toValue = NSValue.init(cgPoint: CGPoint(x: 6 * value + width / 2, y: -1 * value + lineY + lineHeight + interval))
            let line3Rotate = CABasicAnimation.init(keyPath: "transform.rotation.z")
            line3Rotate.toValue = NSNumber.init(value: Float(-pi) / 4 * Float(value) as Float)
            let line3Scale = CABasicAnimation.init(keyPath: "transform.scale.x")
            line3Scale.toValue = NSNumber.init(value: Float(widthValue) / 3 as Float)
            let line3Group = CAAnimationGroup.init()
            line3Group.animations = [line3Move, line3Rotate, line3Scale]
            line3Group.fillMode = kCAFillModeBoth
            line3Group.isRemovedOnCompletion = false
            line3Group.duration = duration * 1 - Double(lastState)
            self.line3.add(line3Group, forKey: nil)
            
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
            path.move(to: CGPoint(x: padding, y: lineY))
            path.addLine(to: CGPoint(x: padding + lineWidth, y: lineY))
            var line: CAShapeLayer
            switch index {
            case 0: line = line1
            case 1: line = line2
            case 2: line = line3
            default: line = line1
            }
            line.frame = CGRect(x: 0, y: (lineHeight + interval) * CGFloat(index - 1), width: width, height: height)
            line.path = path.cgPath
            line.lineWidth = lineHeight
            line.strokeColor = UIColor.white.cgColor
            line.fillColor = UIColor.clear.cgColor
            self.layer.addSublayer(line)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
