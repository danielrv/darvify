//
//  NewReleaseDetailViewController.swift
//  ee.darv.Darvify
//
//  Created by Dan on 22-12-22.
//

import UIKit

class NewReleaseDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    

    var item:Items?
    @IBOutlet var imagenPoster:UIImageView?

    @IBOutlet var lblNombre:UILabel?
    @IBOutlet var lblLabel:UILabel?
    @IBOutlet var lblPopular:UILabel?
    @IBOutlet var tablaArtistas:UITableView?
    
    var listaArtistas:[Artits] = [Artits]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblPopular?.backgroundColor = .red
        self.lblPopular?.textColor = .white
        self.lblPopular?.asCircle()
    
        self.obtenerDatos()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let item = item else { return }
        let imageUrlString = item.images[0].url
        let urlImage = URL(string: imageUrlString)
        guard let urlImagen = urlImage else{
            return
        }
        ImageCacheUtils.shared.imagenParaUrl(url: urlImagen) { image in
            DispatchQueue.main.async {
               
                self.view.backgroundColor = UIColor(patternImage: image.noir)
                self.imagenPoster?.image = image
            }
            
        }
        
        
    }
    
    func obtenerDatos(){
        guard let item = item else { return }
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.string(forKey: "accessToken")
        let contentType     = HeaderParameter(key: "Content-Type", value: "application/json")
        let authorization   = HeaderParameter(key: "Authorization", value: "Bearer \(accessToken!)")
        
        let serverComm = ServerComms()
        serverComm.obtenerDatosGET(endpoint: item.href, headers:[contentType,authorization] , solicitar: Release.self) { objeto, err in
            DispatchQueue.main.async {
                self.lblNombre?.text = objeto?.name
                self.lblLabel?.text = objeto?.label
                self.lblPopular?.text = "\(objeto?.popularity ?? 0)"
                
                if let listaArtistas = objeto?.artists{
                    if( listaArtistas.count > 0){
                        for artista in listaArtistas{
                          
                            self.listaArtistas.append(artista)
                        }
                        self.tablaArtistas?.reloadData()
                        
                    }
                }
                
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaArtistas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let artista = self.listaArtistas[indexPath.row]
        let celda:ArtistaTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArtistaTableViewCell", for: indexPath) as! ArtistaTableViewCell
        celda.lblNombreArtista?.text = artista.name
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let artista = self.listaArtistas[indexPath.row]
        Log(level: .basic, str: "Selecciono \(indexPath.row) -> \(artista.href)")
        let detalleArtistaVC:DetalleArtistaViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetalleArtistaViewController") as! DetalleArtistaViewController
        detalleArtistaVC.artista = artista
        detalleArtistaVC.modalPresentationStyle = .popover
        self.present(detalleArtistaVC, animated: true)
        
        
    }

}
