//
//  MDProgressView.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/6.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

@IBDesignable
class MDProgressView: UIView {

    @IBInspectable
    var color: UIColor = UIColor.lightBlue500 {
        didSet {
            self.progressLayer.strokeColor = self.color.cgColor
        }
    }
    
    @IBInspectable
    var lineWidth: CGFloat = 4 {
        didSet {
            self.progressLayer.lineWidth = self.lineWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    fileprivate let progressLayer = CAShapeLayer()
    
    fileprivate func setup() {
        self.progressLayer.strokeColor = self.color.cgColor
        self.progressLayer.lineWidth = self.lineWidth
        self.progressLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(self.progressLayer)
    }
    
    override func draw(_ rect: CGRect) {
        self.progressLayer.frame = self.bounds
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let radius = CGFloat.minimum(center.x, center.y) - self.lineWidth / 2
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: 0,
                                endAngle: CGFloat.pi * 10,
                                clockwise: true)
        self.progressLayer.path = path.cgPath
    }
    
    func startAnimating() {
        let duration = 2.0
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.duration = duration
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.repeatCount = MAXFLOAT
        self.progressLayer.add(rotation, forKey: "transform.rotation.z")
        
        let strokeStart = CAKeyframeAnimation(keyPath: "strokeStart")
        strokeStart.values = [0.00, 0.00, 0.16,
                              0.16, 0.32, 0.32,
                              0.48, 0.48, 0.64,
                              0.64, 0.80]
        strokeStart.duration = duration * 5
        strokeStart.repeatCount = MAXFLOAT
        var timingFunctions: [CAMediaTimingFunction] = []
        for _ in 0 ..< 11 {
            timingFunctions.append(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        }
        strokeStart.timingFunctions = timingFunctions
        self.progressLayer.add(strokeStart, forKey: "strokeStart")

        let strokeEnd = CAKeyframeAnimation(keyPath: "strokeEnd")
        strokeEnd.values = [0.02, 0.18, 0.18,
                            0.34, 0.34, 0.50,
                            0.50, 0.66, 0.66,
                            0.82, 0.82]
        strokeEnd.duration = duration * 5
        strokeEnd.repeatCount = MAXFLOAT
        self.progressLayer.add(strokeEnd, forKey: "strokeEnd")
        
    }
    
    func stopAnimating() {
        self.progressLayer.removeAllAnimations()
    }

}
