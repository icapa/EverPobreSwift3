//
//  Note+CoreDataProperties.swift
//  Everpobre
//
//  Created by Iván Cayón Palacio on 8/9/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation
import CoreData

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note");
    }

    @NSManaged public var creationDate: NSDate?
    @NSManaged public var modificationDate: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var notebook: Notebook?
    @NSManaged public var photo: Photo?

}
