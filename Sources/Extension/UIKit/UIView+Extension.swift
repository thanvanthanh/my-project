//
//  UIView+Extension.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 22/12/2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                self.layer.borderColor = color.cgColor
            } else {
                self.layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable var shadowBlur: CGFloat {
        get {
            return self.layer.shadowRadius * 2.0
        }
        set {
            self.layer.shadowRadius = newValue / 2.0
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = self.layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                self.layer.shadowColor = color.cgColor
                self.layer.shadowOpacity = 1.0
            } else {
                self.layer.shadowColor = nil
                self.layer.shadowOpacity = 0.0
            }
        }
    }
}
