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

@objc
public class Note: NSManagedObject {
    static let entityName = "Note"
    
    convenience init(notebook: Notebook,
         image: UIImage,
         inContext context: NSManagedObjectContext){
       
        
        // Obtenemos la entity description
        let entity = NSEntityDescription.entity(forEntityName: Note.entityName, in: context)!
        // Llamamos a super
        self.init(entity: entity, insertInto: context)
        // Asignamos propiedades
        self.notebook = notebook
        creationDate = NSDate()
        modificationDate = NSDate()
        // Falta la imagen: tenemos que crear una Photo
        photo = Photo(note: self, image: image, inContext: context)
        
        
    }
    
    convenience init (notebook: Notebook,
        inContext context: NSManagedObjectContext){
        // Obtenemos la entity description
        let entity = NSEntityDescription.entity(forEntityName: Note.entityName, in: context)!
        self.init(entity: entity, insertInto: context)
        self.notebook = notebook
        creationDate = NSDate()
        modificationDate = NSDate()
        
        // le metemos una imagen vacia
        photo = Photo(note: self, inContext: context)
        
    }
}



//MARK: - KVO
extension Note{
    //@nonobjc static let observableKeys = ["text","photo.photoData"]
    static func observableKeys() -> [String] {return ["name","notes"]};
    func setupKVO(){
        // alta en las notificaciones
        // para algunas propiedades
        // Deberes: Usar una la funcion map
        for key in Note.observableKeys(){
            self.addObserver(self,
                             forKeyPath: key,
                             options: [],
                             context: nil)
        }
    }
    
    func tearDownKVO(){
        // Baja en todas las notificaciones
        for key in Notebook.observableKeys(){
            self.removeObserver(self, forKeyPath: key)
        }
    }
    
    public override func observeValue(forKeyPath keyPath: String?,
                                      of object: Any?,
                                      change: [NSKeyValueChangeKey : Any]?,
                                      context: UnsafeMutableRawPointer?) {
        // actualizar modification date
        modificationDate = NSDate()
        
    }

}

//MARK: - Lifecycle
extension Note{
    // Se llama una sola vez
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        setupKVO()
    }
    
    // Se llama varias veces
    public override func awakeFromFetch() {
        super.awakeFromFetch()
        setupKVO()
    }
    
    public override func willTurnIntoFault() {
        super.willTurnIntoFault()
        tearDownKVO()
    }
}








