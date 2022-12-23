//
//  LogUtils.swift
//  ee.darv.Darvify
//
//  Created by Dan on 19-12-22.
//

import Foundation

extension NSObject{

    enum LogLevel {
        case basic
        case unsafe
        case none
    }
    
    /// Funcion para escribir en el log
    /// se basa en el nivel de log requerido, el cual se configura en Confs
    /// ```
    /// func Log(level:LogLevel, str:String)
    /// ```
    /// > Warining: No usar en closures
    ///
    /// - Parameters:
    ///     - level: LogLevel ( .basic | .unsafe) del mensaje, unsafe es para contenidos que no deberían mostrarse en depuración
    ///     - str: String , String que se desea imprimir en el log
    func Log(level:LogLevel, str:String){
        
        let confLevel = Confs.shared.logLevel
        if( confLevel == .none){
            return
        }
        if( confLevel == .basic && level == .basic){
            print(str)
        }else if( confLevel == .unsafe){
            if( level == .unsafe){
                print("⚠️ \(str)")
            }else{
                print(str)
            }
            
        }
        
        
    }
}
