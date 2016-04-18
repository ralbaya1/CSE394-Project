//
//  Pet+CoreDataProperties.swift
//  project
//
//  Created by Tse on 4/14/16.
//  Copyright © 2016 Raid. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Pet {

    @NSManaged var petId: NSNumber?
    @NSManaged var name: String?
    @NSManaged var picture: NSData?

}
