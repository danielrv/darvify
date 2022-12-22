//
//  IntExtensions.swift
//  ee.darv.Darvify
//
//  Created by Dan on 22-12-22.
//

import Foundation

extension Int{
   
    func intConFormato() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ""
        
        return formatter.string(from: NSNumber(value: self)) ?? "🤯"
    }
}

