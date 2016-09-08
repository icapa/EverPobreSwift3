//
//  Note+CoreDataClass.swift
//  Everpobre
//
//  Created by Iván Cayón Palacio on 8/9/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Note)
public class Note: NSManagedObject {
    static let entityName = "Note"
    
    init(notebook: Notebook,
         image: UIImage,
         inContext context: NSManagedObjectContext){
       
        
        // Obtenemos la entity description
        let entity = NSEntityDescription.entity(forEntityName: Note.entityName, in: context)!
        // Llamamos a super
        super.init(entity: entity, insertInto: context)
        // Asignamos propiedades
        self.notebook = notebook
        creationDate = NSDate()
        modificationDate = NSDate()
        // Falta la imagen: tenemos que crear una Photo
        photo = Photo(note: self, image: image, inContext: context)
        
        
    }
    
    init (notebook: Notebook,
          inContext context: NSManagedObjectContext){
        // Obtenemos la entity description
        let entity = NSEntityDescription.entity(forEntityName: Note.entityName, in: context)!
        super.init(entity: entity, insertInto: context)
        self.notebook = notebook
        creationDate = NSDate()
        modificationDate = NSDate()
        
        // le metemos una imagen vacia
        photo = Photo(note: self, inContext: context)
        
        
    }
}
