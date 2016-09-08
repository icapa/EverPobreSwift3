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
//MARK: - KVO

extension Notebook{
    @nonobjc static let observableKeys = ["name","notes"]
    
    func setupKVO(){
        // alta en las notificaciones
        // para algunas propiedades
        // Deberes: Usar una la funcion map
        for key in Notebook.observableKeys{
            self.addObserver(self,
                             forKeyPath: key,
                             options: [],
                             context: nil)
        }
    }
    
    func tearDownKVO(){
        // Baja en todas las notificaciones
        for key in Notebook.observableKeys{
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
extension Notebook{
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
 
