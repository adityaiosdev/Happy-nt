//
//  UIView + Extension.swift
//  gameBitcoin
//
//  Created by Aditya Ramadhan on 02/05/21.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius : CGFloat{
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
