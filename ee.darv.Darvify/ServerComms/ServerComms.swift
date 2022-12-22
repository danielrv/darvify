//
//  ServerComms.swift
//  ee.darv.Darvify
//
//  Created by Dan on 21-12-22.
//

import UIKit


struct HeaderParameter {
    var key:String
    var value:String
}


public class ServerComms: NSObject {

    
    /// Funcion obtener una imagen desde URL
    /// Descarga una imagen desde la URL endpoint
    /// ```
    /// func obtenerImagen(endpoint:String, finalizo: @escaping(_ dato:Data?,_ err:Error?) -> Void)
    /// ```
    /// - Parameters:
    ///     - endpoint: String con la ruta de la imagen
    ///     - finalizo: closure (dato:Data?, err:Error?) , en dato la data de la imagen, si error es distinto a nill entonces ha ocurrido un error
    func obtenerImagen(endpoint:String, finalizo: @escaping(_ dato:Data?,_ err:Error?) -> Void){
        
        let url = URL(string:endpoint)
        let request:NSMutableURLRequest = NSMutableURLRequest()
        request.url = url
        request.httpMethod = "GET"
        
        let session:URLSession = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {  (data, response, err) in
            self.Log(level: .basic, str: "GET a \(endpoint)")
            let httpResp = response as? HTTPURLResponse

            if (httpResp?.statusCode == 200 && err == nil && data != nil){
    
                self.Log(level: .basic, str: "Imagen Descargada OK!")
                finalizo(data,err)
                
            }else{
                finalizo(nil, CustomError.errObtenerImagen)
                if let err = err{
                    self.Log(level: .basic, str: "🚫 \(err)")
                }
                
            }
        }
        task.resume()
        
    }
    /// Funcion obtener Modelos con datos desde URL
    /// Obtiene el JSON desde una URL y crea el modelo solicitado
    /// ```
    /// func obtenerDatosGET<T>(endpoint:String, headers:[HeaderParameter], solicitar:T.Type, finalizo: @escaping(_ objeto:T?, _ err:Error?) ->())
    /// ```
    /// - Parameters:
    ///     - endpoint: String con la ruta del JSON
    ///     - headers: arreglo de HeaderParameter , que van en la cabecera del request
    ///     - solicitar: El tipo de objecto que se solicita, debe ser un modelo y estar implementado
    ///     - finalizo: closue (objeto:T?, err:Error?) , si no hay error el objeto sera del tipo solicitado, si hay error el objeto sera nil y err tendrá un Error
    func obtenerDatosGET<T>(endpoint:String, headers:[HeaderParameter], solicitar:T.Type, finalizo: @escaping(_ objeto:T?, _ err:CustomError?) ->()){
        
        let url = URL(string:endpoint)
        let request:NSMutableURLRequest = NSMutableURLRequest()
        request.url = url
        request.httpMethod = "GET"
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        let session:URLSession = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {  (data, response, err) in
            self.Log(level: .basic, str: "GET a \(endpoint)")
            self.Log(level: .basic, str: "Error en GET \(err)")
            let httpResp = response as? HTTPURLResponse

            if (httpResp?.statusCode == 200 && err == nil && data != nil){
                do {
                    
                    if(solicitar == NewReleases.self){
                        let newReleases = try JSONDecoder().decode(NewReleases.self, from: data!)
                        finalizo(newReleases as? T ,nil)
                    }
                    if(solicitar == Release.self){
                        let newReleases = try JSONDecoder().decode(Release.self, from: data!)
                        finalizo(newReleases as? T ,nil)
                    }
                    if(solicitar == DetalleArtist.self){
                        let detalleArtista = try JSONDecoder().decode(DetalleArtist.self, from: data!)
                        finalizo(detalleArtista as? T, nil)
                    }
                    if(solicitar == GenerosDiponibles.self){
                        
                        let generosDisponibles = try JSONDecoder().decode(GenerosDiponibles.self, from: data!)
                        finalizo(generosDisponibles as? T, nil)
                    }
                    
                }catch{
                   
                    finalizo(nil, CustomError.otros)
                }
            }else{
                
                finalizo(nil,CustomError.distintoA200)
            }
        }
        task.resume()
    }
    
    
}
