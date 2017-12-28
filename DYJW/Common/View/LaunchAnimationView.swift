//
//  LaunchAnimationView.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/28.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

class LaunchAnimationView: UIView {

    static func loadFromNib() -> LaunchAnimationView {
        let view = Bundle.main.loadNibNamed("LaunchAnimationView", owner: nil, options: nil)?.first as! LaunchAnimationView
        view.frame = UIScreen.main.bounds
        return view
    }
    
    func show(in window: UIWindow?) {
        window?.addSubview(self)
        self.startAnimation()
    }
    
    @IBOutlet fileprivate weak var blueMaskView: UIView!
    @IBOutlet fileprivate weak var clearMaskView: UIView!
    @IBOutlet fileprivate weak var launchIcon: UIImageView!
    @IBOutlet fileprivate weak var launchTitleImage: UIImageView!
    
    fileprivate func startAnimation() {
        self.blueAnimation()
        self.imageAlphaAnimation()
        self.dismissAnimation()
    }
    
    fileprivate func blueAnimation() {
        let blueLayer = CAShapeLayer()
        blueLayer.fillColor = 0x00B0FF.rgbColor.cgColor
        blueLayer.frame = self.blueMaskView.bounds
        self.blueMaskView.layer.addSublayer(blueLayer)
        
        let path1 = UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2 - 80),
                                 radius: 40,
                                 startAngle: 0,
                                 endAngle: CGFloat.pi * 2,
                                 clockwise: true)
        blueLayer.path = path1.cgPath
        
        let radius = sqrt(Double(Screen.width * Screen.width + Screen.height * Screen.height)) / 2 + 1
        let path2 = UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2 - 80),
                                 radius: 80,
                                 startAngle: 0,
                                 endAngle: CGFloat.pi * 2,
                                 clockwise: true)
        let path3 = UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2),
                                 radius: CGFloat(radius - 40),
                                 startAngle: 0,
                                 endAngle: CGFloat.pi * 2,
                                 clockwise: true)
        let path4 = UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2),
                                 radius: CGFloat(radius),
                                 startAngle: 0,
                                 endAngle: CGFloat.pi * 2,
                                 clockwise: true)
        
        let animation = CAKeyframeAnimation(keyPath: "path")
        animation.values = [path1.cgPath, path2.cgPath, path3.cgPath, path4.cgPath]
        animation.keyTimes = [0, 0.18, 0.82, 1.0]
        animation.duration = 0.35
        animation.beginTime = CACurrentMediaTime() + 0.15
        animation.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        ]
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeBoth
        blueLayer.add(animation, forKey: "path")
    }
    
    fileprivate func imageAlphaAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 0.15
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeBoth
        self.launchIcon.layer.add(animation, forKey: "opacity")
    }
    
    fileprivate func dismissAnimation() {
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        self.layer.mask = mask
        
        let path1 = UIBezierPath(rect: mask.bounds)
        path1.append(UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2 - 80),
                                  radius: 0.01,
                                  startAngle: 0,
                                  endAngle: CGFloat.pi * 2,
                                  clockwise: true).reversing())
        mask.path = path1.cgPath
        
        let path2 = UIBezierPath(rect: mask.bounds)
        path2.append(UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2 - 80),
                                  radius: 60,
                                  startAngle: 0,
                                  endAngle: CGFloat.pi * 2,
                                  clockwise: true).reversing())
        
        let radius = sqrt(Double(Screen.width * Screen.width + Screen.height * Screen.height)) / 2 + 1
        let path3 = UIBezierPath(rect: mask.bounds)
        path3.append(UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2),
                                  radius: CGFloat(radius - 60),
                                  startAngle: 0,
                                  endAngle: CGFloat.pi * 2,
                                  clockwise: true).reversing())
        
        let path4 = UIBezierPath(rect: mask.bounds)
        path4.append(UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2),
                                  radius: CGFloat(radius),
                                  startAngle: 0,
                                  endAngle: CGFloat.pi * 2,
                                  clockwise: true).reversing())
        
        let animation = CAKeyframeAnimation(keyPath: "path")
        animation.values = [path1.cgPath, path2.cgPath, path3.cgPath, path4.cgPath]
        animation.keyTimes = [0, 0.18, 0.82, 1.0]
        animation.duration = 0.4
        animation.beginTime = CACurrentMediaTime() + 0.75
        animation.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        ]
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeBoth
        animation.delegate = self
        mask.add(animation, forKey: "path")
    }

}

extension LaunchAnimationView {
    
    override func animationDidStop(_ animation: CAAnimation, finished: Bool) {
        if finished {
            self.removeFromSuperview()
        }
    }
}
