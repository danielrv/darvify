//
//  SpotifyLoginProvider.swift
//  ee.darv.Darvify
//
//  Created by Dan on 19-12-22.
//

import Foundation
import UIKit
import CommonCrypto
import Security
import SafariServices
import AuthenticationServices



class SpotifyLoginProvider: NSObject, LoginProvider {
    
    
    
    
    
     func generateCryptographicallySecureRandomOctets(count: Int) throws -> [UInt8] {
        var octets = [UInt8](repeating: 0, count: count)
        let status = SecRandomCopyBytes(kSecRandomDefault, octets.count, &octets)
        if status == errSecSuccess {
            return octets
        } else {
           return [0x00] //throw PKCEError.failedToGenerateRandomOctets
        }
    }
    
     func createCodeVerifier() -> String {
        var buffer = [UInt8](repeating: 0, count: 32)
        _ = SecRandomCopyBytes(kSecRandomDefault, buffer.count, &buffer) // array de 32  Uint8 con valores random
        return Data(buffer)
                .base64EncodedString()
                .replacingOccurrences(of: "+", with: "-")
                .replacingOccurrences(of: "/", with: "_")
                .replacingOccurrences(of: "=", with: "")
                .trimmingCharacters(in: .whitespaces) // se devuelve un string reemplazando los + y / por - y = por nada ( remover)
        
    }
    
     func codeChallenge(for verifier: String) -> String { // recibe el codeVerifier creado anteriormente
        // usar Apple Common Crypto library para no romperme las
        // http://opensource.apple.com//source/CommonCrypto
        guard let data = verifier.data(using: .utf8) else { fatalError() } // crea DATA usando el String
        var buffer = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH)) // crea un buffer para de [Uint8] con un maximo del maximo de bytes para un SHA256 DIGEST
        
        data.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(data.count), &buffer) // coloca los bytes  pasados por SHA256CC del string en el buffer
        }
        
        
        let hash = Data(buffer) // vuelve a tranformar el arreglo de bytes en data
        return hash.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
            .trimmingCharacters(in: .whitespaces) // lo volvemos a crear como String
    }
    
    func requestToken(code:String,redirect:String,verifier:String, completion:@escaping(_ aToken:String, _ rToken:String) ->Void){
        
        let header = HeaderParameter(key: "Content-Type", value: "application/x-www-form-urlencoded")
        let postData = NSMutableData(data: "grant_type=authorization_code&client_id=\(Confs.shared.clientID)&code_verifier=\(verifier)&code=\(code)&redirect_uri=\(redirect)".data(using: String.Encoding.utf8)!) as Data

        guard let _ = NSURL(string: Confs.shared.spotifyTokenURL) else{
            self.Log(level: .basic, str: "Error en String spotifyTokenURL")
            return
            
        }
        let serverComms = ServerComms()
        serverComms.obtenerDatosPOST(endpoint: Confs.shared.spotifyTokenURL, body: postData, headers: [header], solicitar: Credentials.self) { objeto, err in
            
            if (err == nil){
                if let credentials = objeto{
                    completion(credentials.access_token, credentials.refresh_token)
                }else{
                    self.Log(level: .basic, str: "Error en Credentials!")
                }
            }else{
                self.Log(level: .basic, str: "Error al obtener Credentials! \(err)")
            }
        }
        
        
    }
    
    
    /// Funcion para obtener valores de query url
    /// ```
    /// private func getQueryStringParameter(url: String, param: String) -> String?
    /// ```
    /// - Parameters:
    ///     - url: el string de url con las variables y valores
    ///     - param: el nombre del parametro a buscar
    private func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
        /*
        let items = url.queryItems
        for itm in items!{
            print(itm)
        }
         */
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    
    
    /// Funcion para iniciar sesión usando OAuth con Spotify
    /// Obtiene access y refresh token
    /// ```
    /// func initLogin(viewController:UIViewController, completion:@escaping(_ accessToken:String,_ refreshToken:String) -> Void)
    /// ```
    /// - Parameters:
    ///     - viewController: La instancia de UIViewController que necesita hacer login
    ///     - completion: resultado:Bool , accessToken:String, refreshToken:String
    func initLogin(viewController: UIViewController, completion: @escaping (Bool, String, String) -> Void) {
        
        let confs = Confs.shared
        //Crear challenge y verifier
        let codeVerifier = self.createCodeVerifier()
        let challengeStr = self.codeChallenge(for: codeVerifier)
        Log(level: .unsafe, str: "CodeVerifier: \(codeVerifier)")
        Log(level: .unsafe, str: "CodeChallenge: \(challengeStr)")

        let loginURLasString = "\(confs.spotifyAuthURL)?client_id=\(confs.clientID)&response_type=code&code_challenge_method=S256&redirect_uri=\(confs.callBackURI)&code_challenge=\(challengeStr)"
        let url = URL(string: loginURLasString)
        
        Log(level: .basic, str: loginURLasString)
        
        let handler:ASWebAuthenticationSession.CompletionHandler = { (callBack:URL?, error:Error? ) in
            guard error == nil, let successURL = callBack else {
               completion(false,"","")
                return
            }
            self.Log(level: .basic, str: "ASWebAuthenticationSession.CompletionHandler")
            
            let code = self.getQueryStringParameter(url: successURL.absoluteString, param: "code")
            guard let code = code else {
                completion(false,"","")
                 return
                
            }
            
            self.requestToken(code: code, redirect: Confs.shared.callBackURI, verifier: codeVerifier) { aToken, rToken in
                completion(true,aToken,rToken)
            }
            
            
            
        }
        
        let auses = ASWebAuthenticationSession(url: url!, callbackURLScheme: "azhl", completionHandler: handler)
        auses.prefersEphemeralWebBrowserSession = true
        auses.presentationContextProvider = viewController.view.window?.rootViewController
        auses.start()
    
        
        
    }
    
    
}
