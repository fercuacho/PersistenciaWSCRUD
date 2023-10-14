//
//  Publicacion+CoreDataProperties.swift
//  PersistenciaWSCRUD
//
//  Created by José Fernando Cristóbal Huerta on 12/10/23.
//
//

import Foundation
import CoreData


extension Publicacion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Publicacion> {
        return NSFetchRequest<Publicacion>(entityName: "Publicacion")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: Int16
    @NSManaged public var body: String?
    @NSManaged public var userId: Int16

}

extension Publicacion : Identifiable {

}
