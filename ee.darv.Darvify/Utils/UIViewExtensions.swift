//
//  UIViewExtensions.swift
//  ee.darv.Darvify
//
//  Created by Dan on 22-12-22.
//

import Foundation
import UIKit

extension UIView{
    func asCircle(){
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
    
    func borders(radius:CGFloat = 20, bwith:CGFloat = 6){
        self.layer.borderWidth = bwith
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = radius
        self.layer.cornerCurve = .continuous
        
    }
}
