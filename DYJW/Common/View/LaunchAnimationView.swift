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
        
        let startPath = UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2 - 80),
                                     radius: 40,
                                     startAngle: 0,
                                     endAngle: CGFloat.pi * 2,
                                     clockwise: true)
        blueLayer.path = startPath.cgPath
        
        let radius = sqrt(Double(Screen.width * Screen.width + Screen.height * Screen.height)) / 2 + 1
        let endPath = UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2),
                                   radius: CGFloat(radius),
                                   startAngle: 0,
                                   endAngle: CGFloat.pi * 2,
                                   clockwise: true)
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = 0.35
        animation.beginTime = CACurrentMediaTime() + 0.25
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeBoth
        blueLayer.add(animation, forKey: "path")
    }
    
    fileprivate func imageAlphaAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 0.15
        animation.beginTime = CACurrentMediaTime() + 0.25
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeBoth
        self.launchIcon.layer.add(animation, forKey: "opacity")
    }
    
    fileprivate func dismissAnimation() {
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        self.layer.mask = mask
        
        let startPath = UIBezierPath(rect: mask.bounds)
        startPath.append(UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2 - 80),
                                      radius: 0.01,
                                      startAngle: 0,
                                      endAngle: CGFloat.pi * 2,
                                      clockwise: true).reversing())
        mask.path = startPath.cgPath
        
        let radius = sqrt(Double(Screen.width * Screen.width + Screen.height * Screen.height)) / 2 + 1
        let endPath = UIBezierPath(rect: mask.bounds)
        endPath.append(UIBezierPath(arcCenter: CGPoint(x: Screen.width / 2, y: Screen.height / 2),
                                    radius: CGFloat(radius),
                                    startAngle: 0,
                                    endAngle: CGFloat.pi * 2,
                                    clockwise: true).reversing())
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = 0.4
        animation.beginTime = CACurrentMediaTime() + 1.0
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
