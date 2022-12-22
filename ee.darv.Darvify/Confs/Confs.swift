//
//  Confs.swift
//  ee.darv.Darvify
//
//  Created by Dan on 19-12-22.
//

import Foundation

class Confs: NSObject {
    
    static let shared = Confs()
    
    //Log
    var logLevel            = LogLevel.none
    
    //Endpoints
    var spotifyAuthURL      = "DEBES INGRESAR UNA URL PARA SPOTIFY AUTH"
    var spotifyTokenURL     = "DEBES INGRESAR UNA URL PARA SPOTIFY TOKEN"
    //Login
    var clientID            = "CLIENT ID PARA CUENTA APP SPOTIFY DEV"
    var clientSecret        = "SECRET ID PARA CUENTA APP SPOTIFY DEV"
    var callBackURI         = "DEBES INGRESAR EL CALLBACK URI CONFIGURADO EN SPOTIFY DEV"
    var newReleasesURL      = "DEBES INGRESAR EL ENDPOINT PARA NEW RELEASES"
    var genreSeedURL       = "DEBES INGRESAR URL PARA GENEROS"
    private override init() {
        self.spotifyAuthURL  = "https://accounts.spotify.com/authorize"
        self.spotifyTokenURL = "https://accounts.spotify.com/api/token"
        
        self.clientID           = "5f97a7740ff14f3bb9d70f52e6697d40"
        self.clientSecret       = "1e6d3ad500d34325ace70687143d7d11"
        self.callBackURI        = "dvfy://logon/"
        self.newReleasesURL     = "https://api.spotify.com/v1/browse/new-releases"
        self.genreSeedURL       = "https://api.spotify.com/v1/recommendations/available-genre-seeds"
    }
}
