//
//  UIViewControllerExtensions.swift
//  ee.darv.Darvify
//
//  Created by Dan on 20-12-22.
//

import Foundation
import UIKit
import AuthenticationServices

extension UIViewController: ASWebAuthenticationPresentationContextProviding{
    public func presentationAnchor(for session: ASWebAuthenticationSession)
      -> ASPresentationAnchor {
          
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
      }
}
extension UIViewController : ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor{
        return self.view.window ?? ASPresentationAnchor()
    }
}
extension UIViewController{
    
    func mostrarAlerta(titulo:String, texto:String){
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: titulo, message: texto, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default){_ in
                
            }
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true)
        }
        
    }
}
