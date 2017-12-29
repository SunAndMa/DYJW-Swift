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
        
        let colorAnimation = CABasicAnimation(keyPath: "fillColor")
        colorAnimation.fromValue = 0x00B0FF.rgbColor.cgColor
        colorAnimation.toValue = 0x03A9F4.rgbColor.cgColor
        colorAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        colorAnimation.duration = 0.35
        colorAnimation.beginTime = CACurrentMediaTime() + 0.25
        colorAnimation.isRemovedOnCompletion = false
        colorAnimation.fillMode = kCAFillModeBoth
        blueLayer.add(colorAnimation, forKey: "fillColor")
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
 
        /*
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.fillColor = UIColor.white.cgColor
        self.layer.mask = mask
        
        let path = UIBezierPath(rect: self.bounds)
        path.append(self.createPathOfJW().reversing())
        mask.path = path.cgPath
//        self.clearMaskView.layer.addSublayer(mask)
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.0
        animation.toValue = 80.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 1.0
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeBoth
        animation.delegate = self
        mask.add(animation, forKey: "path")
        */
    }
    
    fileprivate func createPathOfJW() -> UIBezierPath {
        let pathString = "M28.1679688,23.2167969 L28.1679688,46.4628906 C28.1679688,49.9433768 28.1321618,52.1813101 28.0605469,53.1767578 C27.9889319,54.1722055 27.6630888,55.0709595 27.0830078,55.8730469 C26.5029268,56.6751342 25.7151742,57.2301417 24.7197266,57.5380859 C23.7242789,57.8460302 22.2239684,58 20.21875,58 L15.6855469,58 L15.6855469,51.9199219 C16.2298204,51.9628908 16.6236967,51.984375 16.8671875,51.984375 C17.511722,51.984375 18.0201804,51.8268245 18.3925781,51.5117188 C18.7649758,51.196613 18.9798174,50.8098981 19.0371094,50.3515625 C19.0944013,49.8932269 19.1230469,49.0052149 19.1230469,47.6875 L19.1230469,23.2167969 L28.1679688,23.2167969 Z M65.7011719,23.2167969 L61.6835938,58 L50.3828125,58 C49.3515573,52.6575254 48.4420612,46.5846694 47.6542969,39.78125 C47.2962222,42.6888166 46.4583399,48.7616726 45.140625,58 L33.9042969,58 L29.8652344,23.2167969 L38.6523438,23.2167969 L39.5761719,35.3554688 L40.5214844,47.0644531 C40.8509131,41.0058291 41.681634,33.0566898 43.0136719,23.2167969 L52.4238281,23.2167969 C52.552735,24.233729 52.8821588,28.0579096 53.4121094,34.6894531 L54.4003906,47.9023438 C54.9016952,39.4947496 55.7395775,31.2663163 56.9140625,23.2167969 L65.7011719,23.2167969 Z"
        let offset = CGPoint(x: Screen.width / 2 - 40, y: Screen.height / 2 - 80 - 40)
        return UIBezierPath.create(with: pathString, offset: offset)
    }

}

extension LaunchAnimationView {
    
    override func animationDidStop(_ animation: CAAnimation, finished: Bool) {
        if finished {
            self.removeFromSuperview()
        }
    }
}
