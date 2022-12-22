//
//  NewReleasesViewController.swift
//  ee.darv.Darvify
//
//  Created by Dan on 21-12-22.
//

import UIKit

class NewReleasesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var actualizarRefreshControl:UIRefreshControl!
    @IBOutlet var tablaNewReleases:UITableView?
    
    var listaItems:[Items] = [Items]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        actualizarRefreshControl = UIRefreshControl()
        self.tablaNewReleases!.addSubview(actualizarRefreshControl)
        actualizarRefreshControl.attributedTitle = NSAttributedString(string: "Actualizar")
        actualizarRefreshControl.addTarget(self, action: #selector(obtenerNuevos), for: .valueChanged)
        DispatchQueue.global(qos: .background).async {
            self.obtenerNuevos(nil)
        }
    }
    
    @objc func obtenerNuevos(_ sender:Any?){
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.string(forKey: "accessToken")
        Log(level: .unsafe, str: "🍕\(accessToken!)")
        
        let contentType     = HeaderParameter(key: "Content-Type", value: "application/json")
        let authorization   = HeaderParameter(key: "Authorization", value: "Bearer \(accessToken!)")
        
        let serverComm = ServerComms()
        serverComm.obtenerDatosGET(endpoint: Confs.shared.newReleasesURL, headers: [contentType,authorization], solicitar: NewReleases.self) { objeto, err in
            if(err != nil){
                self.Log(level: .basic, str: "🚫 \(err!)")
                if( err == .distintoA200){
                    self.mostrarAlerta(titulo: "Ops!", texto: "Parece que hay problemas con la conexión o con tu token\nRecuerda usar un token de desarrollo y tener conexión a internet")
                }
            }else{
                if let lista = objeto?.albums.items{
                    
                    self.listaItems = lista
                    DispatchQueue.main.async {
                        self.tablaNewReleases?.reloadData()
                    }
                }
                
            }
            
            DispatchQueue.main.async {
                self.actualizarRefreshControl.endRefreshing()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda:NewReleasesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewReleasesTableViewCell", for: indexPath) as! NewReleasesTableViewCell
        let item = self.listaItems[indexPath.row]
        
        celda.lblTitulo?.text = item.name
        let texto = "\(item.album_type) 🎵 \(item.release_date)"
        celda.lblGenero?.text = texto
        
        let imageUrlString = item.images[0].url
        
        DispatchQueue.global(qos: .default).async {
            let urlImage = URL(string: imageUrlString)
            guard let urlImagen = urlImage else{
                return
            }
          
            ImageCacheUtils.shared.imagenParaUrl(url: urlImagen) { image in
                DispatchQueue.main.async {
                    celda.poster?.image = image
                }
                
            }
        }
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let item = self.listaItems[indexPath.row]
        Log(level: .basic, str: "Selecciono \(indexPath.row) -> \(item.href)")
        let newReleaseDetailVC:NewReleaseDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewReleaseDetailViewController") as! NewReleaseDetailViewController
        newReleaseDetailVC.item = item
        newReleaseDetailVC.modalPresentationStyle = .popover
        self.present(newReleaseDetailVC, animated: true)
        
    }
}
