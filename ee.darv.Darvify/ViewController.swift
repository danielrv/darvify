//
//  ViewController.swift
//  ee.darv.Darvify
//
//  Created by Dan on 19-12-22.
//

import UIKit
public typealias ASPresentationAnchor = UIWindow
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func iniciarLogin(_ sender:Any?){
        Log(level: .basic, str: "Iniciando Login")
        let spotifyLoginProvider = SpotifyLoginProvider()
        spotifyLoginProvider.initLogin(viewController: self) { resultado, accessToken, refreshToken in
            if( resultado == true ){
                self.Log(level: .unsafe, str: "Login completo")
                self.Log(level: .unsafe, str: "accessToken: \(accessToken)")
                self.Log(level: .unsafe, str: "refreshToken: \(refreshToken)")
                let userDefaults = UserDefaults.standard
                userDefaults.set(accessToken, forKey: "accessToken")
                userDefaults.set(refreshToken, forKey: "refreshToken")
                userDefaults.synchronize()
                
                DispatchQueue.main.async {
                    let tabbarHome:HomeTabbarViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabbarViewController") as! HomeTabbarViewController
                    tabbarHome.modalPresentationStyle = .currentContext
                    tabbarHome.modalTransitionStyle = .flipHorizontal
                    self.present(tabbarHome, animated: true)
                }
                
            }
        }
    }


}

