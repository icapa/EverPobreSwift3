//
//  Photo+CoreDataClass.swift
//  Everpobre
//
//  Created by Iván Cayón Palacio on 8/9/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc
public class Photo: NSManagedObject {
    static let entityName = "Photo"
    
    var image : UIImage{
        get{
            return UIImage(data: photoData! as Data)!
        }
        set{
            photoData = UIImageJPEGRepresentation(newValue, 0.9) as NSData?
        }
    }
    
    /*
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    */
    
    
    init (note: Note,
          image: UIImage,
          inContext context: NSManagedObjectContext){
        
        let ent = NSEntityDescription.entity(forEntityName: Photo.entityName, in: context)!
        
        super.init(entity: ent, insertInto: context)
        
        // Añado la nota
        addToNotes(note)
        
        // Transformo UIImage en un data y lo encasqueto
        self.image = image
    }
    
    
    init(note: Note, inContext context: NSManagedObjectContext){
        let ent = NSEntityDescription.entity(forEntityName: Photo.entityName, in: context)!
        super.init(entity: ent, insertInto: context)
        addToNotes(note)
    }
    
    
}
