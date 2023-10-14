//
//  Post.swift
//  PersistenciaWSCRUD
//
//  Created by José Fernando Cristóbal Huerta on 12/10/23.
//

import Foundation

struct Post : Codable {
    let id : Int?
    let title : String
    let body : String
    let userId : Int
}
