//
//  UIRippleView.swift
//  DYJW
//
//  Created by 风筝 on 16/9/12.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

private var colorKey: UInt8 = 0
private var rippleKey: UInt8 = 1
private var cancelRippleKey: UInt8 = 2
private var rippleLayerKey: UInt8 = 3
private var clipLayerKey: UInt8 = 4
private var startPointKey: UInt8 = 5
private var groupAnimationKey: UInt8 = 6
private var rippleFinishActionKey: UInt = 7

extension UIView: CAAnimationDelegate {
    
    // MARK:- Properties
    var rippleColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &colorKey) as? UIColor
        }
        set(value) {
            objc_setAssociatedObject(self, &colorKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    
    fileprivate var ripple: Bool {
        get {
            let value = objc_getAssociatedObject(self, &rippleKey) as? Bool
            return value ?? false
        }
        set {
            objc_setAssociatedObject(self, &rippleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    fileprivate var cancelRipple: Bool {
        get {
            let value = objc_getAssociatedObject(self, &cancelRippleKey) as? Bool
            return value ?? false
        }
        set {
            objc_setAssociatedObject(self, &cancelRippleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    fileprivate var rippleLayer: CAShapeLayer {
        get {
            var rippleLayer: CAShapeLayer!
            if let layer = objc_getAssociatedObject(self, &rippleLayerKey) as? CAShapeLayer {
                rippleLayer = layer
            } else {
                let rippleLayer = CAShapeLayer()
                rippleLayer.isGeometryFlipped = true
                rippleLayer.lineWidth = 0
                rippleLayer.fillColor = self.rippleColor?.cgColor
                rippleLayer.lineJoin = kCALineJoinBevel
                self.rippleLayer = rippleLayer
                self.clipLayer.addSublayer(rippleLayer)
                return rippleLayer
            }
            self.clipLayer.frame = self.bounds
            rippleLayer.frame = self.layer.bounds
            return rippleLayer
        }
        set(value) {
            objc_setAssociatedObject(self, &rippleLayerKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    fileprivate var clipLayer: CALayer {
        get {
            var clipLayer: CALayer!
            if let layer = objc_getAssociatedObject(self, &clipLayerKey) as? CALayer {
                clipLayer = layer
            } else {
                clipLayer = CALayer()
                clipLayer.cornerRadius = self.layer.cornerRadius
                clipLayer.masksToBounds = true
                self.clipLayer = clipLayer
                self.layer.addSublayer(clipLayer)
                return clipLayer
            }
            clipLayer.frame = self.bounds
            return clipLayer
        }
        set(value) {
            objc_setAssociatedObject(self, &clipLayerKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    fileprivate var startPoint: CGPoint? {
        get {
            return objc_getAssociatedObject(self, &startPointKey) as? CGPoint
        }
        set {
            objc_setAssociatedObject(self, &startPointKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    typealias RippleFinish = () -> Void
    var rippleFinishAction: RippleFinish? {
        get {
            return objc_getAssociatedObject(self, &rippleFinishActionKey) as? RippleFinish
        }
        set(value) {
            objc_setAssociatedObject(self, &rippleFinishActionKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    
    // MARK:- Create ripple view
    func createRippleView(_ color: UIColor = UIColor.grey300, alpha: CGFloat = 0.5) {
        if !self.ripple {
            self.rippleColor = color.withAlphaComponent(alpha);
            self.ripple = true;
            self.cancelRipple = false;
        }
    }
    
    // MARK:- Touch events
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.cancelRipple = false
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startRipple), userInfo: touches, repeats: false)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.cancelRipple = false
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(endRipple), userInfo: nil, repeats: false)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.cancelRipple = true
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(endRipple), userInfo: nil, repeats: false)
    }
    
    @objc fileprivate func startRipple(_ timer: Timer) {
        let touches:Set<UITouch> = timer.userInfo as! Set<UITouch>
        if !self.ripple || self.cancelRipple {
            return
        }
        let touch = touches.first
        let point = touch?.location(in: self)
        self.startPoint = point!
        self.rippleLayer.timeOffset = self.rippleLayer.convertTime(CACurrentMediaTime(), from: self.rippleLayer)
        self.rippleStart(point!, offset: 0, speed: 1)
    }
    
    @objc fileprivate func endRipple() {
        if !self.ripple {
            return
        }
        guard let point = self.startPoint else {
            return
        }
        let startTime = self.rippleLayer.timeOffset
        let timeSinceBegan = self.rippleLayer.convertTime(CACurrentMediaTime(), from: self.rippleLayer) - startTime
        self.rippleStart(point, offset: timeSinceBegan, speed: 12)
    }
    
    fileprivate func rippleStart(_ point: CGPoint, offset: CFTimeInterval, speed: Float) {
        let width = self.frame.size.width
        let height = self.frame.size.height
        let radius = sqrt(width * width + height * height) / 2
        let duration: TimeInterval = 3
        
        // 绘制圆形
        let circle = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height / 2), radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        self.rippleLayer.path = circle.cgPath
        
        // 移动动画，将圆心从手指处移动到控件中心
        let moveAnimation = CABasicAnimation(keyPath: "position")
        let fromValue = 1 - (duration - offset > 0 ? (duration - offset) / duration: 0)
        let fromPoint = CGPoint(x: (width / 2 - point.x) * CGFloat(fromValue) + point.x, y: (height / 2 - point.y) * CGFloat(fromValue) + point.y)
        moveAnimation.fromValue = NSValue(cgPoint: fromPoint)
        moveAnimation.toValue = NSValue(cgPoint: CGPoint(x: width / 2, y: height / 2))
        moveAnimation.duration = duration - offset > 0 ? duration - offset: 0
        
        // 比例动画，将圆形从0个像素的大小放大到铺满整个控件
        let pathAnimation = CABasicAnimation(keyPath: "transform.scale")
        pathAnimation.duration = duration - offset > 0 ? duration - offset: 0
        pathAnimation.fromValue = fromValue
        pathAnimation.toValue = 1
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        
        // 透明度动画，当圆形扩散到整个控件时让圆形淡出
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = offset > duration ? (duration * 2 - offset) / duration: 1
        alphaAnimation.toValue = 0
        alphaAnimation.duration = offset > duration ? duration * 2 - offset: duration
        alphaAnimation.beginTime = offset > duration ? 0: duration - offset
        
        // 将以上三个动画组合并按顺序显示
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = duration * 2 - offset;
        groupAnimation.animations = [moveAnimation, pathAnimation, alphaAnimation]
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.delegate = self
        groupAnimation.speed = speed
        
        self.rippleLayer.add(groupAnimation, forKey: "groupAnimation")
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if !flag {
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(rippleFinished), userInfo: nil, repeats: false)
        }
    }
    
    @objc fileprivate func rippleFinished() {
        self.rippleFinishAction?()
    }
}

extension UIButton {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
}
