//
//  MDSwitch.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/15.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

@IBDesignable
class MDSwitch: UIControl {

    @IBInspectable
    var isOn: Bool {
        get {
            return self.isSwitchOn
        }
        set {
            let oldValue = self.isOn
            self.setOn(newValue, animated: false)
            if newValue != oldValue {
                self.sendActions(for: .valueChanged)
            }
        }
    }
    
    @IBInspectable
    var onTintColor: UIColor = UIColor.lightBlue500 {
        didSet {
            
        }
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            super.frame = newValue
            var rect = newValue
            rect.origin = CGPoint.zero
            self.draw(rect)
        }
    }
    
    fileprivate var isSwitchOn = false
    fileprivate let defaultColor = UIColor.grey500
    fileprivate let lineLayer = CAShapeLayer()
    fileprivate let lineMaskLayer = CAShapeLayer()
    fileprivate let thumbLayer = CAShapeLayer()
    fileprivate let thumbMaskLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        var frame = frame
        frame.size = CGSize(width: 37, height: 30)
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.setup()
    }
    
    fileprivate func setup() {
        self.backgroundColor = UIColor.clear
        
        self.layer.addSublayer(self.lineLayer)
        self.layer.addSublayer(self.thumbLayer)
        
        self.lineLayer.lineWidth = 1
        self.lineLayer.strokeColor = self.defaultColor.withAlphaComponent(0.44).cgColor
        
        self.thumbLayer.fillColor = self.defaultColor.cgColor
        
        self.lineLayer.mask = self.lineMaskLayer
        self.thumbLayer.mask = self.thumbMaskLayer
    }
    
    override func draw(_ rect: CGRect) {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: rect.width / 2 - 19, y: rect.height / 2))
        linePath.addLine(to: CGPoint(x: rect.width / 2 + 19, y: rect.height / 2))
        self.lineLayer.path = linePath.cgPath
        
        let centerX = self.isSwitchOn ? rect.width / 2 + 9.5 : rect.width / 2 - 9.5
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: rect.height / 2),
                                      radius: 9.5,
                                      startAngle: 0,
                                      endAngle: CGFloat.pi * 2,
                                      clockwise: true)
        self.thumbLayer.path = circlePath.cgPath
        
        let maskPath = UIBezierPath(rect: rect)
        maskPath.append(UIBezierPath(arcCenter: CGPoint(x: centerX, y: rect.height / 2),
                                     radius: 8,
                                     startAngle: 0,
                                     endAngle: CGFloat.pi * 2,
                                     clockwise: true).reversing())
        self.thumbMaskLayer.path = maskPath.cgPath
        self.lineMaskLayer.path = maskPath.cgPath
    }
    
    func setOn(_ isOn: Bool, animated: Bool) {
        self.isSwitchOn = isOn
        if animated {
            self.beginAnimation(isOn)
        }
    }
    
    fileprivate func beginAnimation(_ isOn: Bool) {
        
        let duration = 0.25
        
        // 更改颜色
        let fromColor = isOn ? self.defaultColor : self.onTintColor
        let toColor = isOn ? self.onTintColor : self.defaultColor
        let thumbColorAnimation = CABasicAnimation(keyPath: "fillColor")
        thumbColorAnimation.fromValue = fromColor.cgColor
        thumbColorAnimation.toValue = toColor.cgColor
        thumbColorAnimation.duration = duration
        thumbColorAnimation.isRemovedOnCompletion = false
        thumbColorAnimation.fillMode = kCAFillModeBoth
        thumbColorAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.thumbLayer.add(thumbColorAnimation, forKey: "fillColor")
        
        let lineColorAnimation = CABasicAnimation(keyPath: "strokeColor")
        lineColorAnimation.fromValue = fromColor.withAlphaComponent(0.44).cgColor
        lineColorAnimation.toValue = toColor.withAlphaComponent(0.44).cgColor
        lineColorAnimation.duration = duration
        lineColorAnimation.isRemovedOnCompletion = false
        lineColorAnimation.fillMode = kCAFillModeBoth
        lineColorAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.lineLayer.add(lineColorAnimation, forKey: "strokeColor")
        
        // 位移及遮罩
        let fromCenterX = isOn ? self.bounds.width / 2 - 9.5 : self.bounds.width / 2 + 9.5
        let toCenterX = isOn ? self.bounds.width / 2 + 9.5 : self.bounds.width / 2 - 9.5
        
        let fromCirclePath = UIBezierPath(arcCenter: CGPoint(x: fromCenterX, y: self.bounds.height / 2),
                                        radius: 9.5,
                                        startAngle: 0,
                                        endAngle: CGFloat.pi * 2,
                                        clockwise: true)
        let toCirclePath = UIBezierPath(arcCenter: CGPoint(x: toCenterX, y: self.bounds.height / 2),
                                        radius: 9.5,
                                        startAngle: 0,
                                        endAngle: CGFloat.pi * 2,
                                        clockwise: true)
        
        let moveAnimation = CABasicAnimation(keyPath: "path")
        moveAnimation.fromValue = fromCirclePath.cgPath
        moveAnimation.toValue = toCirclePath.cgPath
        moveAnimation.duration = duration
        moveAnimation.isRemovedOnCompletion = false
        moveAnimation.fillMode = kCAFillModeBoth
        moveAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.thumbLayer.add(moveAnimation, forKey: "path")
        
        let fromMaskPath = UIBezierPath(rect: self.bounds)
        fromMaskPath.append(UIBezierPath(arcCenter: CGPoint(x: fromCenterX, y: self.bounds.height / 2),
                                       radius: isOn ? 8.0 : 0.01,
                                       startAngle: 0,
                                       endAngle: CGFloat.pi * 2,
                                       clockwise: true).reversing())
        let toMaskPath = UIBezierPath(rect: self.bounds)
        toMaskPath.append(UIBezierPath(arcCenter: CGPoint(x: toCenterX, y: self.bounds.height / 2),
                                       radius: isOn ? 0.01 : 8.0,
                                     startAngle: 0,
                                     endAngle: CGFloat.pi * 2,
                                     clockwise: true).reversing())
        
        let circleMaskAnimation = CABasicAnimation(keyPath: "path")
        circleMaskAnimation.fromValue = fromMaskPath.cgPath
        circleMaskAnimation.toValue = toMaskPath.cgPath
        circleMaskAnimation.duration = duration
        circleMaskAnimation.isRemovedOnCompletion = false
        circleMaskAnimation.fillMode = kCAFillModeBoth
        circleMaskAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.thumbMaskLayer.add(circleMaskAnimation, forKey: "path")
        
        let lineMaskAnimation = CABasicAnimation(keyPath: "path")
        lineMaskAnimation.fromValue = fromMaskPath.cgPath
        lineMaskAnimation.toValue = toMaskPath.cgPath
        lineMaskAnimation.duration = duration
        lineMaskAnimation.isRemovedOnCompletion = false
        lineMaskAnimation.fillMode = kCAFillModeBoth
        lineMaskAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.lineMaskLayer.add(lineMaskAnimation, forKey: "path")
    }
    
    fileprivate var beginPoint: CGPoint?
    fileprivate var isCurrentOn: Bool = false
    fileprivate var shouldAnimate = true
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.beginPoint = touches.first?.location(in: self)
        self.isCurrentOn = self.isSwitchOn
        self.shouldAnimate = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let beginPoint = self.beginPoint else {
            return
        }
        guard let location = touches.first?.location(in: self) else {
            return
        }
        let offset = location.x - beginPoint.x
        if self.isSwitchOn {
            if offset >= 0 && self.isCurrentOn == false {
                // 原本是打开，现在也是打开
                self.isCurrentOn = true
                self.shouldAnimate = false
                self.beginAnimation(self.isCurrentOn)
                self.impact()
            } else if offset <= -27 && self.isCurrentOn == true {
                // 原本是打开，现在是关闭
                self.isCurrentOn = false
                self.shouldAnimate = false
                self.beginAnimation(self.isCurrentOn)
                self.impact()
            }
        } else {
            if offset >= 27 && self.isCurrentOn == false {
                // 原本是关闭，现在是打开
                self.isCurrentOn = true
                self.shouldAnimate = false
                self.beginAnimation(self.isCurrentOn)
                self.impact()
            } else if offset <= 0 && self.isCurrentOn == true {
                // 原本是关闭，现在也是关闭
                self.isCurrentOn = false
                self.shouldAnimate = false
                self.beginAnimation(self.isCurrentOn)
                self.impact()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if self.shouldAnimate {
            self.setOn(!self.isOn, animated: true)
            self.sendActions(for: .valueChanged)
            self.impact()
        } else if self.isSwitchOn != self.isCurrentOn {
            self.isSwitchOn = self.isCurrentOn
            self.sendActions(for: .valueChanged)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    
    fileprivate func impact() {
        if #available(iOS 10.0, *) {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.prepare()
            impact.impactOccurred()
        }
    }

}
