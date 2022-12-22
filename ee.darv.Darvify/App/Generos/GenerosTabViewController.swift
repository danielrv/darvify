//
//  GenerosTabViewController.swift
//  ee.darv.Darvify
//
//  Created by Dan on 22-12-22.
//

import UIKit

class GenerosTabViewController: UIViewController, UITableViewDataSource {
    
    var actualizarRefreshControl:UIRefreshControl!
    @IBOutlet var tablaGeneros:UITableView?
    var listaGeneros:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        actualizarRefreshControl = UIRefreshControl()
        self.tablaGeneros!.addSubview(actualizarRefreshControl)
        actualizarRefreshControl.attributedTitle = NSAttributedString(string: "Actualizar")
        actualizarRefreshControl.addTarget(self, action: #selector(obtenerDatos), for: .valueChanged)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.obtenerDatos()
    }
    @objc func obtenerDatos(){
        
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.string(forKey: "accessToken")
        let contentType     = HeaderParameter(key: "Content-Type", value: "application/json")
        let authorization   = HeaderParameter(key: "Authorization", value: "Bearer \(accessToken!)")
        
        let serverComm = ServerComms()
        serverComm.obtenerDatosGET(endpoint: Confs.shared.genreSeedURL, headers:[contentType,authorization] , solicitar: GenerosDiponibles.self) { objeto, err in
            if(err != nil){
                if( err == .distintoA200){
                    self.mostrarAlerta(titulo: "Ops!", texto: "Parece que hay problemas con la conexión o con tu token\nRecuerda usar un token de desarrollo y tener conexión a internet")
                    
                }
            }else{
                if let generos = objeto{
                    self.listaGeneros = generos.genres
                    DispatchQueue.main.async {
                        self.tablaGeneros?.reloadData()
                       
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.actualizarRefreshControl.endRefreshing()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaGeneros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda:GeneroTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GeneroTableViewCell", for: indexPath) as! GeneroTableViewCell
        
        let nombreGenero = self.listaGeneros[indexPath.row]
        celda.lblNombreGenero?.text = nombreGenero
        
        return celda
    }

}
