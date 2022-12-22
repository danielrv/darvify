//
//  LoginProvider.swift
//  ee.darv.Darvify
//
//  Created by Dan on 19-12-22.
//

import Foundation
import UIKit
protocol LoginProvider {
    func initLogin(viewController:UIViewController, completion:@escaping(_ resultado:Bool, _ accessToken:String,_ refreshToken:String) -> Void) 
}
