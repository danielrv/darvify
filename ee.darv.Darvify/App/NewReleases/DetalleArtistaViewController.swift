//
//  DetalleArtistaViewController.swift
//  ee.darv.Darvify
//
//  Created by Dan on 22-12-22.
//

import UIKit

class DetalleArtistaViewController: UIViewController {

    var artista:Artits?
    
    @IBOutlet var fotoArtistaView:UIImageView?
    @IBOutlet var lblFollowers:UILabel?
    @IBOutlet var lblGeneros:UILabel?
    @IBOutlet var lblNombre:UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fotoArtistaView?.alpha = 0
        self.lblNombre?.alpha = 0
        self.fotoArtistaView?.borders()
        //self.fotoArtistaView?.image = UIImage(systemName: "arrow.triangle.2.circlepath.camera")
        // Do any additional setup after loading the view.
        self.lblNombre?.backgroundColor = .white
        self.lblNombre?.borders(radius: 3.0, bwith: 3)
        
        self.obtenerDatos()
    }
    

    
    func obtenerDatos(){
        guard let artista = artista else { return }
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.string(forKey: "accessToken")
        let contentType     = HeaderParameter(key: "Content-Type", value: "application/json")
        let authorization   = HeaderParameter(key: "Authorization", value: "Bearer \(accessToken!)")
        
        let serverComm = ServerComms()
        serverComm.obtenerDatosGET(endpoint: artista.href, headers:[contentType,authorization] , solicitar: DetalleArtist.self) { objeto, err in
            
            if(err != nil){
                self.mostrarAlerta(titulo: "Ops!", texto: "Revisa tu conexión a internet!")
            }else{
                if let artista = objeto{
                    let imageCacheUtils = ImageCacheUtils.shared
                    if let urlImagen = artista.images.first?.url{
                        imageCacheUtils.imagenParaUrl(url: URL(string:urlImagen)!) { imagen in
                            DispatchQueue.main.async {
                                self.view.backgroundColor = UIColor(patternImage: imagen.xray)
                                self.fotoArtistaView?.image = imagen
                                self.lblNombre?.text = artista.name
                                let followersInt = artista.followers.total
                                let followersString = "Followers: \(followersInt.formatted())"
                                self.lblFollowers?.text = followersString
                                var strGeneros:String = ""
                                for genero in artista.genres{
                                    strGeneros.append("▪️\(genero) \n")
                                }
                                self.lblGeneros?.text = strGeneros
                                UIView.animate(withDuration: 0.3, delay: 0) {
                                    self.lblNombre?.alpha = 1
                                    self.fotoArtistaView?.alpha = 1
                                }
                            }
                        }
                    }
                    
                }
            }
            
            
            
        }
    }

    

}
