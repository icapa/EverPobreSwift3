//
//  Notebook+CoreDataClass.swift
//  Everpobre
//
//  Created by Iván Cayón Palacio on 8/9/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation
import CoreData

@objc(Notebook)
public class Notebook: NSManagedObject {
    
    static let entityName = "Notebook"
    
    init(name: String, inContext context: NSManagedObjectContext){
        // Necesitamos la entidad de Notebook
        let entity = NSEntityDescription.entity(forEntityName: Notebook.entityName, in: context)!
        
        //llamamos a super
        super.init(entity: entity, insertInto: context)
        
        // Asignamos valores a las fechas
        creationDate = NSDate()
        modificationDate = NSDate()
        
        
    }
}
