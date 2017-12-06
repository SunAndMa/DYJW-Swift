//
//  MDTextField.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/6.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

@IBDesignable
class MDTextField: UITextField {

    @IBInspectable
    var placeholderColor: UIColor? = UIColor.grey500 {
        didSet {
            self.placeholderLayer.foregroundColor = self.placeholderColor?.cgColor
        }
    }
    
    @IBInspectable
    var placeholderFontSize: CGFloat = 12 {
        didSet {
            let font = self.font ?? UIFont.systemFont(ofSize: self.placeholderFontSize)
            self.placeholderLayer.font = font.fontName as CFTypeRef
            self.placeholderLayer.fontSize = self.placeholderFontSize
        }
    }
    
    @IBInspectable
    var underlineColor: UIColor? = UIColor.grey300 {
        didSet {
            self.underlineLayer.strokeColor = self.underlineColor?.cgColor
        }
    }
    
    @IBInspectable
    var underlineTintColor: UIColor? = UIColor.lightBlue500 {
        didSet {
            self.underlineTintLayer.strokeColor = self.underlineTintColor?.cgColor
        }
    }
    
    override var placeholder: String? {
        get {
            return self.placeholderLayer.string as? String
        }
        set {
            self.placeholderLayer.string = newValue
        }
    }
    
    override var attributedPlaceholder: NSAttributedString? {
        get {
            return self.placeholderLayer.string as? NSAttributedString
        }
        set {
            self.placeholderLayer.string = newValue
        }
    }
    
    override var text: String? {
        get {
            return super.text
        }
        set {
            if self.isPlaceholderUp {
                super.text = newValue
            } else {
                self.beginEditingAnimation()
                super.text = newValue
                self.endEditingAnimation()
            }
        }
    }
    
    fileprivate let placeholderLayer = CATextLayer()
    fileprivate let underlineLayer = CAShapeLayer()
    fileprivate let underlineTintLayer = CAShapeLayer()
    fileprivate var isPlaceholderUp = false
    fileprivate var observation: NSKeyValueObservation?
    fileprivate var placeholderLabel: UILabel? {
        get {
            return self.value(forKeyPath: "_placeholderLabel") as? UILabel
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
        self.setup()
    }
    
    fileprivate func setup() {
        self.placeholderLabel?.isHidden = true
        self.placeholder = self.placeholderLabel?.text
        
        self.layer.addSublayer(self.underlineLayer)
        self.layer.addSublayer(self.underlineTintLayer)
        
        self.underlineLayer.lineWidth = 1
        self.underlineLayer.strokeColor = self.underlineColor?.cgColor
        
        self.underlineTintLayer.lineWidth = 1
        self.underlineTintLayer.strokeColor = self.underlineTintColor?.cgColor
        self.underlineTintLayer.strokeStart = 0.5
        self.underlineTintLayer.strokeEnd = 0.5
        
        let font = self.font ?? UIFont.systemFont(ofSize: self.placeholderFontSize)
        self.placeholderLayer.font = font.fontName as CFTypeRef
        self.placeholderLayer.fontSize = self.placeholderFontSize
        self.placeholderLayer.isWrapped = true
        self.placeholderLayer.contentsScale = Screen.scale
        self.placeholderLayer.foregroundColor = self.placeholderColor?.cgColor
        self.layer.addSublayer(self.placeholderLayer)
        
        self.addTarget(self, action: #selector(beginEditingAnimation), for: .editingDidBegin)
        self.addTarget(self, action: #selector(endEditingAnimation), for: .editingDidEnd)
        
    }
    
    override func draw(_ rect: CGRect) {
        let underLineY = rect.height / 4 * 3
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: underLineY))
        path.addLine(to: CGPoint(x: rect.size.width, y: underLineY))

        self.underlineLayer.path = path.cgPath
        self.underlineTintLayer.path = path.cgPath
        self.placeholderLayer.frame = CGRect(x: 0,
                                             y: (rect.height - self.placeholderFontSize) / 2 - 1,
                                             width: rect.width,
                                             height: self.placeholderFontSize + 2)
    }
    
    @objc fileprivate func beginEditingAnimation() {
        self.startAnimation(true)
    }
    
    @objc fileprivate func endEditingAnimation() {
        self.startAnimation(false)
    }
    
    @objc fileprivate func textDidChanged() {
        if let label = self.placeholderLabel {
            self.layer.addSublayer(label.layer)
        }
    }
    
    fileprivate func startAnimation(_ isEditing: Bool) {
        let duration: TimeInterval = 0.25
        
        if (self.text?.length ?? 0) == 0 {
            let moveAnimation = CABasicAnimation(keyPath: "position")
            moveAnimation.fromValue = CGPoint(x: self.width / 2,
                                              y: self.height / 2 + (isEditing ? 0 : -18))
            moveAnimation.toValue = CGPoint(x: self.width / 2,
                                            y: self.height / 2 + (isEditing ? -18 : 0))
            moveAnimation.duration = duration
            moveAnimation.fillMode = kCAFillModeForwards
            moveAnimation.isRemovedOnCompletion = false
            self.placeholderLayer.add(moveAnimation, forKey: "position")
            self.isPlaceholderUp = true
        } else {
            self.isPlaceholderUp = false
        }
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.duration = duration
        strokeStartAnimation.fromValue = isEditing ? 0.5 : 0
        strokeStartAnimation.toValue = isEditing ? 0 : 0.5
        strokeStartAnimation.fillMode = kCAFillModeForwards
        strokeStartAnimation.isRemovedOnCompletion = false
        self.underlineTintLayer.add(strokeStartAnimation, forKey:"strokeStart")
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = duration
        strokeEndAnimation.fromValue = isEditing ? 0.5 : 1.0
        strokeEndAnimation.toValue = isEditing ? 1.0 : 0.5
        strokeEndAnimation.fillMode = kCAFillModeForwards
        strokeEndAnimation.isRemovedOnCompletion = false
        self.underlineTintLayer.add(strokeEndAnimation, forKey:"strokeEnd")
    }

}
