//
//  HamburgerView.swift
//  DYJW
//
//  Created by FlyKite on 16/9/14.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

class HamburgerView: UIView {
    
    enum HamburgerState: Int {
        case normal
        case back
        case popBack
    }
    
    fileprivate let hamburgerWidth: CGFloat = 56
    fileprivate let hamburgerHeight: CGFloat = 56
    fileprivate let padding: CGFloat = 18.0
    fileprivate let lineWidth: CGFloat = 20.0
    fileprivate let lineHeight: CGFloat = 2.0
    fileprivate let interval: CGFloat = 3.0
    fileprivate let lineY: CGFloat = 28.0
    fileprivate let duration: TimeInterval = 0.25
    
    // Lines
    fileprivate let line1: CAShapeLayer = CAShapeLayer()
    fileprivate let line2: CAShapeLayer = CAShapeLayer()
    fileprivate let line3: CAShapeLayer = CAShapeLayer()
    
    // HamburgerViewState
    var state: HamburgerState = .normal {
        willSet(newValue) {
            if newValue != .popBack {
                stateValue = newValue == .normal ? 0 : 1
            } else {
                stateValue = state == .normal ? 1 : 0
            }
        }
    }
    
    // The stateValue is between 0.00 and 1.00 for Hamburger rotation
    var stateValue: CGFloat = 0 {
        willSet(newValue) {
            guard newValue >= 0 else {
                self.stateValue = 0
                return
            }
            guard newValue <= 1 else {
                self.stateValue = 1
                return
            }
            
            // 整个控件的旋转
            let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
            rotate.fromValue = CGFloat.pi * (self.state == .normal ? stateValue : 2 - stateValue)
            rotate.toValue = CGFloat.pi * (self.state == .normal ? newValue : 2 - newValue)
            rotate.fillMode = kCAFillModeBoth
            rotate.isRemovedOnCompletion = false
            rotate.duration = duration * Double(1 - stateValue)
            self.layer.add(rotate, forKey: nil)
            
            // 两条横线长度变化的值
            let widthValue = 3 - newValue
            
            // Line1的变换
            let line1Move = CABasicAnimation(keyPath: "position")
            line1Move.toValue = NSValue(cgPoint: CGPoint(x: 6 * newValue + hamburgerWidth / 2, y: 1 * newValue + lineY - lineHeight - interval))
            let line1Rotate = CABasicAnimation(keyPath: "transform.rotation.z")
            line1Rotate.toValue = CGFloat.pi / 4 * newValue
            let line1Scale = CABasicAnimation(keyPath: "transform.scale.x")
            line1Scale.toValue = widthValue / 3
            let line1Group = CAAnimationGroup()
            line1Group.animations = [line1Move, line1Rotate, line1Scale]
            line1Group.fillMode = kCAFillModeBoth
            line1Group.isRemovedOnCompletion = false
            line1Group.duration = duration * Double(1 - stateValue)
            self.line1.add(line1Group, forKey: nil)
            
            // Line3的变换
            let line3Move = CABasicAnimation(keyPath: "position")
            line3Move.toValue = NSValue(cgPoint: CGPoint(x: 6 * newValue + hamburgerWidth / 2, y: -1 * newValue + lineY + lineHeight + interval))
            let line3Rotate = CABasicAnimation(keyPath: "transform.rotation.z")
            line3Rotate.toValue = -CGFloat.pi / 4 * newValue
            let line3Scale = CABasicAnimation(keyPath: "transform.scale.x")
            line3Scale.toValue = widthValue / 3
            let line3Group = CAAnimationGroup()
            line3Group.animations = [line3Move, line3Rotate, line3Scale]
            line3Group.fillMode = kCAFillModeBoth
            line3Group.isRemovedOnCompletion = false
            line3Group.duration = duration * Double(1 - stateValue)
            self.line3.add(line3Group, forKey: nil)
        }
    }
    
    // MARK:- initialize
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 56.0, height: 56.0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: hamburgerWidth, height: hamburgerHeight))
        for index in 0...2 {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: padding, y: lineY))
            path.addLine(to: CGPoint(x: padding + lineWidth, y: lineY))
            var line: CAShapeLayer
            switch index {
            case 0: line = line1
            case 1: line = line2
            case 2: line = line3
            default: line = line1
            }
            line.frame = CGRect(x: 0, y: (lineHeight + interval) * CGFloat(index - 1), width: hamburgerWidth, height: hamburgerHeight)
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
