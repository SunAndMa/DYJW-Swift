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
    var color: UIColor! {
        get {
            return objc_getAssociatedObject(self, &colorKey) as? UIColor
        }
        set(value) {
            objc_setAssociatedObject(self, &colorKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var ripple: Bool {
        get {
            let number = objc_getAssociatedObject(self, &rippleKey) as? NSNumber
            return number == nil ? false: number!.boolValue
        }
        set(value) {
            objc_setAssociatedObject(self, &rippleKey, NSNumber.init(value: value as Bool), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var cancelRipple: Bool {
        get {
            let number = objc_getAssociatedObject(self, &cancelRippleKey) as? NSNumber
            return number == nil ? false: number!.boolValue
        }
        set(value) {
            objc_setAssociatedObject(self, &cancelRippleKey, NSNumber.init(value: value as Bool), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var rippleLayer: CAShapeLayer {
        get {
            var _rippleLayer = objc_getAssociatedObject(self, &rippleLayerKey) as? CAShapeLayer
            if _rippleLayer == nil {
                self.clipLayer = CALayer.init()
                self.clipLayer.cornerRadius = self.layer.cornerRadius
                self.clipLayer.masksToBounds = true
                
                _rippleLayer = CAShapeLayer.init()
                _rippleLayer!.isGeometryFlipped = true
                _rippleLayer!.lineWidth = 0
                _rippleLayer!.fillColor = self.color.cgColor
                _rippleLayer!.lineJoin = kCALineJoinBevel
                self.clipLayer.addSublayer(_rippleLayer!)
                self.rippleLayer = _rippleLayer!
                self.layer.addSublayer(self.clipLayer)
            }
            self.clipLayer.frame = self.bounds;
            _rippleLayer!.frame = self.layer.bounds;
            return _rippleLayer!;
        }
        set(value) {
            objc_setAssociatedObject(self, &rippleLayerKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var clipLayer: CALayer {
        get {
            return objc_getAssociatedObject(self, &clipLayerKey) as! CALayer
        }
        set(value) {
            objc_setAssociatedObject(self, &clipLayerKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var startPoint: CGPoint {
        get {
            let value: NSValue = objc_getAssociatedObject(self, &startPointKey) as! NSValue
            return value.cgPointValue
        }
        set(value) {
            objc_setAssociatedObject(self, &startPointKey, NSValue.init(cgPoint: value), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var groupAnimation: CAAnimationGroup {
        get {
            return objc_getAssociatedObject(self, &groupAnimationKey) as! CAAnimationGroup
        }
        set(value) {
            objc_setAssociatedObject(self, &groupAnimationKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
//    typealias rippleFinish = () -> Void
//    var rippleFinishAction: rippleFinish {
//        get {
//            return objc_getAssociatedObject(self, &rippleFinishActionKey) as! rippleFinish
//        }
//        set(value) {
//            objc_setAssociatedObject(self, &rippleFinishActionKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
    /*
    var frame: CGRect {
        didSet {
            if self.ripple {
                self.clipLayer.frame = self.bounds;
                self.rippleLayer.frame = self.layer.bounds;
            }
        }
    }
 */
    
    // MARK:- Create ripple view
    func createRippleView() {
        self.createRippleView(UIColor.grey300().withAlphaComponent(0.5))
    }
    
    func createRippleView(_ color: UIColor) {
        if !self.ripple {
            self.color = color;
            self.ripple = true;
            self.cancelRipple = false;
        }
    }
    
    func createRippleView(_ color: UIColor, alpha: CGFloat) {
        self.createRippleView(color.withAlphaComponent(alpha))
    }
    
    func rippleFinished() {
        
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
    
    func startRipple(_ timer: Timer) {
        let touches = timer.userInfo!
        if !self.ripple || self.cancelRipple {
            return
        }
        let array = (touches as AnyObject).allObjects
        let touch = array?[0]
        let point = touch.location(in: self)
        self.startPoint = point
        self.rippleLayer.timeOffset = self.rippleLayer.convertTime(CACurrentMediaTime(), from: self.rippleLayer)
        self.rippleStart(point, offset: 0, speed: 1)
    }
    
    func endRipple() {
        if !self.ripple {
            return
        }
        let point: CGPoint = self.startPoint
        let startTime = self.rippleLayer.timeOffset
        let timeSinceBegan = self.rippleLayer.convertTime(CACurrentMediaTime(), from: self.rippleLayer) - startTime
        self.rippleStart(point, offset: timeSinceBegan, speed: 12)
    }
    
    func rippleStart(_ point: CGPoint, offset: CFTimeInterval, speed: Float) {
        let width = self.frame.size.width
        let height = self.frame.size.height
        let radius = sqrt(width * width + height * height) / 2
        let duration: TimeInterval = 3
        
        // 绘制圆形
        let circle = UIBezierPath.init(arcCenter: CGPoint(x: width / 2, y: height / 2), radius: radius, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        self.rippleLayer.path = circle.cgPath
        
        // 移动动画，将圆心从手指处移动到控件中心
        let moveAnimation = CABasicAnimation.init(keyPath: "position")
        let fromValue = 1 - (duration - offset > 0 ? (duration - offset) / duration: 0)
        let fromPoint = CGPoint(x: (width / 2 - point.x) * CGFloat(fromValue) + point.x, y: (height / 2 - point.y) * CGFloat(fromValue) + point.y)
        moveAnimation.fromValue = NSValue.init(cgPoint: fromPoint)
        moveAnimation.toValue = NSValue.init(cgPoint: CGPoint(x: width / 2, y: height / 2))
        moveAnimation.duration = duration - offset > 0 ? duration - offset: 0
        
        // 比例动画，将圆形从0个像素的大小放大到铺满整个控件
        let pathAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        pathAnimation.duration = duration - offset > 0 ? duration - offset: 0
        pathAnimation.fromValue = fromValue
        pathAnimation.toValue = 1
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        
        // 透明度动画，当圆形扩散到整个控件时让圆形淡出
        let alphaAnimation = CABasicAnimation.init(keyPath: "opacity")
        alphaAnimation.fromValue = offset > duration ? (duration * 2 - offset) / duration: 1
        alphaAnimation.toValue = 0
        alphaAnimation.duration = offset > duration ? duration * 2 - offset: duration
        alphaAnimation.beginTime = offset > duration ? 0: duration - offset
        
        // 将以上三个动画组合并按顺序显示
        let groupAnimation = CAAnimationGroup.init()
        groupAnimation.duration = duration * 2 - offset;
        groupAnimation.animations = [moveAnimation, pathAnimation, alphaAnimation]
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.delegate = self
        groupAnimation.speed = speed
        self.groupAnimation = groupAnimation
        
        self.rippleLayer.add(groupAnimation, forKey: "groupAnimation")
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if self.responds(to: #selector(rippleFinished)) && !flag {
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(rippleFinished), userInfo: nil, repeats: false)
        }
        //    } else if(self.rippleFinishAction && !flag) {
        //    self.rippleFinishAction();
        //    }
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
