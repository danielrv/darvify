//
//  Modelos.swift
//  ee.darv.Darvify
//
//  Created by Dan on 21-12-22.
//

import Foundation


public struct Credentials:Codable{
    var access_token:String
    var refresh_token:String
}
public struct GenerosDiponibles:Codable {
    var genres:[String]
}
public struct Release:Codable{
    var name:String
    var label:String
    var popularity:Int
    var artists:[Artits]
}

public struct DetalleArtist:Codable{
    var followers:Followers
    var genres:[String]
    var images:[Imagenes]
    var name:String
}
public struct Followers:Codable{
    var total:Int
}
public struct Artits:Codable{
    var name:String
    var href:String
}
public struct NewReleases:Codable{
    var albums:Album
}

public struct Album:Codable{
    
    var items:[Items]
}
public struct Items:Codable{
    var album_type:String
    var name:String
    var type:String
    var release_date:String
    var images:[Imagenes]
    var href:String
}
public struct Imagenes:Codable{
    var url:String
}

public enum CustomError: Error {
    
    case distintoA200
    case jsonNoValido
    case decodeError
    case errObtenerImagen
    case otros
    
}
