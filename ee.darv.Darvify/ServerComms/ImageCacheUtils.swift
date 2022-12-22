//
//  ImageCacheUtils.swift
//  ee.darv.Darvify
//
//  Created by Dan on 21-12-22.
//

import UIKit

class ImageCacheUtils: NSObject {

    static let shared = ImageCacheUtils()
    
    private override init() {
        
    }
    /// Funcion obtener una imagen usa, si existe en disco la devuelve, sino la descarga y devuelve
    /// Descarga una imagen desde la URL si no existe en disco
    /// ```
    /// func imagenParaUrl(url:URL, finalizar:@escaping(_ image:UIImage) ->Void)
    /// ```
    /// - Parameters:
    ///     - url: URL con la ruta de la imagen
    ///     - finalizar: closure (image:UIImage) , devuelve un UIImage con la imagen descargada o nil si no exite la la imagen en la url
    func imagenParaUrl(url:URL, finalizar:@escaping(_ image:UIImage) ->Void){
        DispatchQueue.global(qos: .background).async {

            
            do{
                let documents = try FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let ending = url.lastPathComponent
                
                let imageFileName = "Image-\(ending)"
                let imagenEnDisco = documents.appending(path: imageFileName)
                
                
                let imagenExisteEnDisco = FileManager.default.fileExists(atPath: imagenEnDisco.path())
                
                if( imagenExisteEnDisco == true){
                    
                    let imagenFile = try Data.init(contentsOf: imagenEnDisco)
                    if let imagenRet = UIImage.init(data: imagenFile){
                        finalizar(imagenRet)
                    }
                    
                }else{
                    
                    //Descargar
                    let serverComm = ServerComms()
                    serverComm.obtenerImagen(endpoint: url.absoluteString) { dato, err in
                        if(err == nil && dato != nil){
                            do{
                                self.Log(level: .unsafe, str: "Guardando Imagen en \(imagenEnDisco)")
                                try dato?.write(to: imagenEnDisco, options: .atomic)
                                
                                if let imagenRet = UIImage.init(data: dato!){
                                    
                                    finalizar(imagenRet)
                                }
                            }catch{
                                self.Log(level: .basic, str: "Error guardar imagen -> \(error)")
                            }
                            
                        }
                    }
                }
                
            }catch{
                self.Log(level: .basic, str: "Error imagenParaUrl -> \(error)")
            }
        }
        
    }
}
